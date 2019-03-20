#include "uart_init.s"
#include "uart_regs.h"
#include "csd_zynq_peripherals.h"

#define TIMER_INITIAL 30303029

.extern csd_main

.align 8

csd_entry:
	b csd_reset
	b csd_undefined
	b csd_software_interrupt
	b csd_prefetch
	b csd_data
	b csd_not_used
	b csd_irq
	b csd_fiq

.global main
main:

	// Disable interrupt: Turn on I bit in CPSR
    cpsID i

	cps #0x12	   	       /* IRQ mode */
	ldr	r13,=irq_stack_top /* stack pointer setup for IRQ mode */

	cps #0x13		       /* supervisor mode */
	ldr	r13,=svc_stack_top /* stack pointer setup for SVC mode */

    cps #0x11		       /* FIQ mode */
	ldr	r13,=fiq_stack_top /* stack pointer setup for FIQ mode */

	cps #0x1F	           /* SYS mode */

	// Set VBAR (Vector Base Address Register) to the base of my interrupt vector table
    ldr     r0, =csd_entry
    mcr     p15, 0, r0, c12, c0, 0
    dsb
    isb

	// Enable interrupt: Turn off I bit in CPSR
    cpsIE i

// ---------------------------
// Generic Interrupt Controller (GIC) setup - Begin
//

	// CPU Interface ID Register
	ldr r0, =GICC_IIDR
	ldr r3, [r0]

	// CPU Controller Type Register
	ldr r0, =GICD_TYPER
	ldr r3, [r0]

	// CPU Binary Pointer Register
	ldr r0, =GICC_BPR
	ldr r3, [r0]

	// Distributor Control Register
	ldr r0, =GICD_CTLR
	ldr r1, [r0]
	mov r2, #1       // Enable
	orr r1, r1, r2
	str r1, [r0]
	ldr r3, [r0]

	 // Interrupt Set-Enable Register 0
	ldr r0, =GICD_ISENABLER0
	ldr r1, [r0]
	mov r2, #1 << 29   // Enable #29 (Private Timer)
	orr r1, r1, r2
	str r1, [r0]
	ldr r3, [r0]

	// Interrupt Priority Register #7
	ldr r0, =GICD_PRIOR7
	ldr r1, [r0]
	mov r2, #1 << 8    // 2nd Highest: 1 for ID# 29 (Private Timer)
	orr r1, r1, r2
	str r1, [r0]
	ldr r3, [r0]

	// CPU Interface Control Register
	ldr r0, =GICC_CTLR
	ldr r1, [r0]
	mov r2, #1        // Enable
	orr r1, r1, r2
	str r1, [r0]
	ldr r3, [r0]

 	// CPU Interface Interrupt Priority Mask Register
	ldr r0, =GICC_PMR
	ldr r1, [r0]
	mov r2, #0xFF     // Lowest
	orr r1, r1, r2
	str r1, [r0]
	ldr r3, [r0]

//
// Generic Interrupt Controller (GIC) setup - End
// ---------------------------


// ---------------------------
// Private Timer setup - Begin
//

 	// Private Timer Load Register
	ldr r0, =PRIVATE_LOAD
 	ldr r1, =TIMER_INITIAL
 	str r1, [r0]

 	// Private Timer Control Register
  	ldr r0, =PRIVATE_CONTROL
 	mov r1, #10 << 8   // Prescalar
 	orr r1, r1, #7     // IRQ Enable, Auto-Reload, Timer Enable
 	str r1, [r0]

//
// Private Timer setup - End
// ----------------------------
  	ldr r0, =PRIVATE_COUNTER
	ldr r1, =PRIVATE_STATUS
 	ldr r2, =GICD_ISPENDR0

forever:
   ldr r5, [r0]
   ldr r6, [r1]
   ldr r7, [r2]
   b forever


// ----------------------------
// Interrupt Service Routines (ISRs) - Begin
//

csd_software_interrupt:
csd_reset:
csd_undefined:
csd_prefetch:
csd_data:
csd_not_used:
csd_irq:

	stmfd sp!, {r0-r12, lr}

 	// Interrupt Ack
  	ldr r0, =GICC_IAR
	ldr r11, [r0]

	ldr r3, =hour //r3 is address of hour
	ldr r4, =minute//r4 is address of minute
	ldr r5, =second//r5 is address of second

	ldrb r0, [r3] //load hour
	ldrb r1, [r4] //load minute
	ldrb r2, [r5] //load second

	cmp r0, #99 // if hour is 99
	cmpeq r1, #59//and if minute is 59
	cmpeq r2, #59//and if second is 59 ,or 99 : 59 : 59
	moveq r0, #0 //hour = 0
	moveq r1, #0 //minute = 0
	moveq r2, #-1 //second = -1 and increment second at next instrution
				//start from 00 : 00 : 00

	add r2, r2, #1 //increment one second

	cmp r2, #60 // if second is 60
	moveq r2, #0 // second = 0
	addeq r1, r1, #1 // increment minute

	cmp r1, #60 // if minute is 60
	moveq r1, #0 // minute = 0
	addeq r0, r0, #1 //increment hour

	strb r0, [r3] //store hour
	strb r1, [r4] //store minute
	strb r2, [r5] //store second

	bl csd_main //get string time "hour : minute : second"

 print: // print string part

	ldr 	r10, =UART1_BASE


	// ---------  Check to see if the Tx FIFO is empty ------------------------------
	ldr 	r8, [r10, #UART_CHANNEL_STS_REG0_OFFSET]	//get channel status register
	and	r8, r8, #0x8		//transmitter FIFO status 0: not empty 1: empty
	cmp	r8, #0x8				// check if TxFIFO is empty and ready to receive new data
	bne	print	// if TxFIFO is NOT empty, keep checking until it is empty

	ldrb    r7, =#0x0d // carriage return
	strb	r7, [r10, #UART_TX_RX_FIFO0_OFFSET]//store that byte to TxRx FIFO

print_time:
	ldrb    r7, [r0], #1 //print r0, r0 is time string in c code
	strb	r7, [r10, #UART_TX_RX_FIFO0_OFFSET]
	cmp     r7, #0x00 // if next char is not null
	bne		print_time // keep printing



 	// Clear Interrupt Status bit
  	ldr r0, =PRIVATE_STATUS
  	mov r1, #1
	str r1, [r0]

 	// End-of-Interrupt
  	ldr r0, =GICC_EOIR
	str r11, [r0]

	ldmfd sp!, {r0-r12, lr}
    subs pc, lr, #4

csd_fiq:
	b .

//
// Interrupt Service Routines (ISRs) - End
// ----------------------------

.data
.align 4

irq_stack:     .space 1024
irq_stack_top:
fiq_stack:     .space 1024
fiq_stack_top:
svc_stack:     .space 1024
svc_stack_top:
second: .byte 0
minute: .byte 0
hour: .byte 0

led_initial: .word 0xC3
