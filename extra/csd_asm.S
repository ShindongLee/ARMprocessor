#include "uart_regs.h"
#include "csd_zynq_peripherals.h"

#define TIMER_INITIAL 30302

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
	ldr	r13,=irq_stack_top



	cps #0x13		       /* supervisor mode */


	ldr r1, =task1_c //address of task1
	ldr r2, =task2_c //address of task2 + 4
	add r2, r2, #4
	ldr r3, =task3_c //address of task3 + 4
	add r3, r3, #4

	ldr r4, =task1_stack_top // task1 stack top
	ldr r5, =task2_stack_top // task2 stack top
	ldr r6, =task3_stack_top // task3 stack top


	ldr r13, =task1_PCB_top //PCB pointer of task1
	stmdb r13,{r1} //lr in IRQ mode of task1 stores address of task1
	add r13,r13,#52 //r13 of task1 stores task1 stacktop
	str r4,[r13]
	ldr r13, =task2_PCB_top //PCB pointer of task2
	stmdb r13,{r2} //lr in IRQ mode of task2 stores address of task2
	add r13,r13,#52 //r13 of task2 stores task2 stacktop
	str r5,[r13]
	ldr r13, =task3_PCB_top //PCB pointer of task3
	stmdb r13,{r3} //lr in IRQ mode of task3 stores address of task3
	add r13,r13,#52 //r13 of task3 stores task3 stacktop
	str r6,[r13]

	ldr	r13,=svc_stack_top /* stack pointer setup for SVC mode */



	// Set VBAR (Vector Base Address Register) to the base of my interrupt vector table
    ldr     r0, =csd_entry
    mcr     p15, 0, r0, c12, c0, 0
    dsb
    isb

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


	// Enable interrupt: Turn off I bit in CPSR
    cpsIE i


	cps #0x10		       /* USER mode */
	ldr pc, =task1_c


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
	ldr sp, =irq_stack_top //sp points irq stack top
	stm sp,{r0-lr}^ //store user mode registers in irq stack
	mrs r0, spsr //copy spsr to r0
	stmdb sp,{r0,lr} //store spsr and lr in irq mode in irq stack

	ldr r3, =task_next //check next task number
	ldr r2, [r3]

	cmp r2, #1 // if it is 1
	moveq r2, #2 // next = 2
	streq r2, [r3]
	beq task1 //go to task1

	cmp r2, #2 //if it is 2
	moveq r2, #3 //next = 3
	streq r2, [r3]
	beq task2 //go to task 2

	cmp r2, #3 // if it is 3
	moveq r2, #1 // next = 1
	streq r2, [r3]
	beq task3 // go to 3

	task1://pause task 3 and begin task 1

	ldr sp, =task3_PCB_top //sp points task3_PCB
	stmdb sp, {r0,lr} //store spsr and lr in task3_PCB
	ldr sp, =irq_stack_top //sp points irq_stack_top
	ldm sp, {r0-lr}^ //load user mode register from irq_stack
	ldr sp, =task3_PCB_top //sp points task3_PCB
	stm sp, {r0-lr}^ //store user mode registers to task3 PCB



	 // Interrupt Ack
  	ldr r0, =GICC_IAR
	ldr r11, [r0]

 	// Clear Interrupt Status bit
  	ldr r0, =PRIVATE_STATUS
  	mov r1, #1
	str r1, [r0]

 	// End-of-Interrupt
  	ldr r0, =GICC_EOIR
	str r11, [r0]

	ldr sp, =task1_PCB_top // sp points task1_PCB
	ldmdb sp, {r0,lr} //load spsr in r0 and lr
	msr spsr_all, r0 //copy spsr from r0
	ldm sp, {r0-lr}^ //load user mode registers

   subs pc, lr, #4 //return to user mode


	task2: //pause task 1 and begin task 2
	//ldmdb sp, {r0,lr}
	//mov r2, sp
	ldr sp, =task1_PCB_top //sp points task1_PCB
	stmdb sp, {r0,lr} //store spsr and lr in task1_PCB
	ldr sp, =irq_stack_top //sp points irq_stack_top
	//mov sp, r2
	ldm sp, {r0-lr}^ //load user mode register from irq_stack
	ldr sp, =task1_PCB_top //sp points task1_PCB
	stm sp, {r0-lr}^ //store user mode registers to task1 PCB

	 // Interrupt Ack
  	ldr r0, =GICC_IAR
	ldr r11, [r0]

 	// Clear Interrupt Status bit
  	ldr r0, =PRIVATE_STATUS
  	mov r1, #1
	str r1, [r0]

 	// End-of-Interrupt
  	ldr r0, =GICC_EOIR
	str r11, [r0]

	ldr sp, =task2_PCB_top // sp points task2_PCB
	ldmdb sp, {r0,lr} //load spsr in r0 and lr
	msr spsr_all, r0 //copy spsr from r0
	ldm sp, {r0-lr}^ //load user mode registers

   subs pc, lr, #4 //return to user mode

	task3://pause task 2 and begin task 3
	//ldmdb sp, {r0,lr}
	//mov r2, sp
	ldr sp, =task2_PCB_top //sp points task2_PCB
	stmdb sp, {r0,lr} //store spsr and lr in task2_PCB
	ldr sp, =irq_stack_top //sp points irq_stack_top
	//mov sp, r2
	ldm sp, {r0-lr}^ //load user mode register from irq_stack
	ldr sp, =task2_PCB_top //sp points task2_PCB
	stm sp, {r0-lr}^ //store user mode registers to task2 PCB

	 // Interrupt Ack
  	ldr r0, =GICC_IAR
	ldr r11, [r0]

 	// Clear Interrupt Status bit
  	ldr r0, =PRIVATE_STATUS
  	mov r1, #1
	str r1, [r0]

 	// End-of-Interrupt
  	ldr r0, =GICC_EOIR
	str r11, [r0]

	ldr sp, =task3_PCB_top // sp points task3_PCB
	ldmdb sp, {r0,lr} //load spsr in r0 and lr
	msr spsr_all, r0 //copy spsr from r0
	ldm sp, {r0-lr}^ //load user mode registers

   subs pc, lr, #4 //return to user mode

csd_fiq:
	b .

//
// Interrupt Service Routines (ISRs) - End
// ----------------------------

.data
.align 4

user_stack:	   .space 1024
user_stack_top:
irq_stack:     .space 1024
irq_stack_top:
fiq_stack:     .space 1024
fiq_stack_top:
svc_stack:     .space 1024
svc_stack_top:

task1_PCB:		.space 512
task1_PCB_top:	.space 256
task2_PCB:		.space 512
task2_PCB_top:	.space 256
task3_PCB:		.space 512
task3_PCB_top:	.space 256

task1_stack:		.space 1024
task1_stack_top:
task2_stack:		.space 1024
task2_stack_top:
task3_stack:		.space 1024
task3_stack_top:



task_next: .word 2


