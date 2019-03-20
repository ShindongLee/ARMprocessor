
#define csd_LED_ADDR	0x41200000
#define keyboard_input  0x00101af0
//store the number pressed in keyboard_input

#include "uart_init.s"
#include "uart_print.s"


.extern csd_main

.align 8

// Our interrupt vector table
csd_entry:
	b csd_reset
	b .
	b .
	b .
	b .
	b .
	b csd_irq
	b .

.global main
csd_reset:
main:

uart_init // uart √ ±‚»≠

ldr r11, =#0x41200000 // address of LEDs
mov r12, #0b00000001 // next value of LEDs
ldr r4, =keyboard_input //store the number pressed in keyboard_input

ldr 	r10, =UART1_BASE
ldr 	r9, =string1 //menu

trans_loop: //print menu

	// ---------  Check to see if the Tx FIFO is empty ------------------------------
	ldr 	r8, [r10, #UART_CHANNEL_STS_REG0_OFFSET]	//get channel status register
	and	r8, r8, #0x8		//transmitter FIFO status 0: not empty 1: empty
	cmp	r8, #0x8				// check if TxFIFO is empty and ready to receive new data
	bne	trans_loop		// if TxFIFO is NOT empty, keep checking until it is empty

	ldrb     r7, [r9], #1 //load one byte to r7 from r9 (string1)
	strb	r7, [r10, #UART_TX_RX_FIFO0_OFFSET]	@ fill the TxFIFO with 0x48 //store that byte to TxRx FIFO
	cmp      r7, #0x00 //compare r7 with null (end of string1)
	bne		trans_loop //if it is not null keep transmitting

	ldreq 	r9, =string1// if finished, load address of string1 to r9 again

	ldr r6, =UART1_BASE
	add r6, r6, #UART_TX_RX_FIFO0_OFFSET // get UART Tx Rx FIFO register



recvloop:
	// check empty: bit#1 is Rx FIFO empty or not (1: empty, 0: not empty)
	ldr 	r8, [r10, #UART_CHANNEL_STS_REG0_OFFSET]
	and r8, r8, #1<<1 // Receiver FIFO status 0: not empty 1: empty
	cmp r8, #0  // is r8 zero?
	bne jump // if not, Rx FIFO status is empty, go to jump

	// read data and transmit it back to sender
	ldreq r7, [r6]
	streq r7, [r6]
	subeq r7, r7, #48 //in ascii code, char '1' is 49
	streq r7, [r4] //store the number pressed



	moveq r5, #13   // 0xD (13) is carriage return in ASCII
	streq r5, [r6]
	moveq r5, #10 // 0xA (10) is linefeed in ASCII
	streq r5, [r6]
	beq trans_loop


jump:

	bl csd_main
	strb r12, [r11] // turn on next leds

	cmp r12, #0b10000000 // if leds output is 10000000 (if ld7 is turned on)
	beq jump1			 // next leds output is 00000001

	mov r12, r12, LSL#1  // r12=r12*2, turn on next led

	b recvloop

jump1:
	mov r12, #1 //set leds to 00000001
	b recvloop





forever:
	nop
	b forever


.data
.align 4


.data
string1:
	.ascii "----------- LED On Peroid ----------"
	.byte 0x0D
	.byte 0x0A
	.ascii "1. 100ms 2. 200ms 3. 300ms 4. 400ms"
	.byte 0x0D
	.byte 0x0A
	.ascii "5. 500ms 6. 600ms 7. 700ms 8. 1sec"
	.byte 0x0D
	.byte 0x0A
	.ascii "-------------------------------------"
	.byte 0x0D
	.byte 0x0A
	.ascii "Select : "
	.byte 0x00

// Normal Interrupt Service Routine
csd_irq:
	b .
