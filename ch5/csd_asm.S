#include "uart_init.s"
#include "uart_regs.h"

.align 8

 //Our interrupt vector table
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

uart_init // uart ÃÊ±âÈ­

///debugging start

stmia r13!, {r0 - r12} // store r0 ~ r12 register in stack
mrs r5, cpsr // copy cpsr register in r5
sub r0, r13, #52 // save original stack pointer in r0
mov r1, r14  // save link register
sub r2, r15, #24 //save original pc in r2
stmia r13!, {r0 - r2} // save sp, lr, pc
sub r13, r13, #64 //retrieve stack pointer
ldr r9, =string1 //store address of string1

mov r4, #0 //index of registerloop r4 = 0

bl registerloop //print string part and all registers in hex

bl trans_loop //print string part

and r6, r5, #0xf0000000 //leave nzcv part only of cpsr
mov r6, r6, LSR#28  //remove seven 0s in hex

bl trans_loop2 //print nzcv of cpsr register

bl trans_loop3 //print E A I F T, and ISETSTATE

bl trans_loop // print string part

bl trans_loop4 //print current mode and cpsr register in hex

bl trans_loop // print string part


mov r14, r1 // back up link register
mov r13, r0 // back up stack pointer
ldmia r13!, {r0 - r12} // back up r0 ~ r12 registers
sub r13, r13, #52 //back up stack pointer again

//debugging ends


	mov r10, #0 //use r10 as a temp
	mov r11, #0 //use r11 as i of outerloop
	mov r12, #0 //use r12 as j of loop

///debugging start

stmia r13!, {r0 - r12} // store r0 ~ r12 register in stack
mrs r5, cpsr // copy cpsr register in r5
sub r0, r13, #52 // save original stack pointer in r0
mov r1, r14  // save link register
sub r2, r15, #24 //save original pc in r2
stmia r13!, {r0 - r2} // save sp, lr, pc
sub r13, r13, #64 //retrieve stack pointer
ldr r9, =string1 //store address of string1

mov r4, #0 //index of registerloop r4 = 0

bl registerloop //print string part and all registers in hex

bl trans_loop //print string part

and r6, r5, #0xf0000000 //leave nzcv part only of cpsr
mov r6, r6, LSR#28  //remove seven 0s in hex

bl trans_loop2 //print nzcv of cpsr register

bl trans_loop3 //print E A I F T, and ISETSTATE

bl trans_loop // print string part

bl trans_loop4 //print current mode and cpsr register in hex

bl trans_loop // print string part


mov r14, r1 // back up link register
mov r13, r0 // back up stack pointer
ldmia r13!, {r0 - r12} // back up r0 ~ r12 registers
sub r13, r13, #52 //back up stack pointer again

//debugging ends

ldr r0, =Input_data //save address of input

///debugging start

stmia r13!, {r0 - r12} // store r0 ~ r12 register in stack
mrs r5, cpsr // copy cpsr register in r5
sub r0, r13, #52 // save original stack pointer in r0
mov r1, r14  // save link register
sub r2, r15, #24 //save original pc in r2
stmia r13!, {r0 - r2} // save sp, lr, pc
sub r13, r13, #64 //retrieve stack pointer
ldr r9, =string1 //store address of string1

mov r4, #0 //index of registerloop r4 = 0

bl registerloop //print string part and all registers in hex

bl trans_loop //print string part

and r6, r5, #0xf0000000 //leave nzcv part only of cpsr
mov r6, r6, LSR#28  //remove seven 0s in hex

bl trans_loop2 //print nzcv of cpsr register

bl trans_loop3 //print E A I F T, and ISETSTATE

bl trans_loop // print string part

bl trans_loop4 //print current mode and cpsr register in hex

bl trans_loop // print string part


mov r14, r1 // back up link register
mov r13, r0 // back up stack pointer
ldmia r13!, {r0 - r12} // back up r0 ~ r12 registers
sub r13, r13, #52 //back up stack pointer again

//debugging ends

ldr r1, =Output_data//save address of output

///debugging start

stmia r13!, {r0 - r12} // store r0 ~ r12 register in stack
mrs r5, cpsr // copy cpsr register in r5
sub r0, r13, #52 // save original stack pointer in r0
mov r1, r14  // save link register
sub r2, r15, #24 //save original pc in r2
stmia r13!, {r0 - r2} // save sp, lr, pc
sub r13, r13, #64 //retrieve stack pointer
ldr r9, =string1 //store address of string1

mov r4, #0 //index of registerloop r4 = 0

bl registerloop //print string part and all registers in hex

bl trans_loop //print string part

and r6, r5, #0xf0000000 //leave nzcv part only of cpsr
mov r6, r6, LSR#28  //remove seven 0s in hex

bl trans_loop2 //print nzcv of cpsr register

bl trans_loop3 //print E A I F T, and ISETSTATE

bl trans_loop // print string part

bl trans_loop4 //print current mode and cpsr register in hex

bl trans_loop // print string part


mov r14, r1 // back up link register
mov r13, r0 // back up stack pointer
ldmia r13!, {r0 - r12} // back up r0 ~ r12 registers
sub r13, r13, #52 //back up stack pointer again

//debugging ends

	ldmia r0!, {r2-r9} //
///debugging start

stmia r13!, {r0 - r12} // store r0 ~ r12 register in stack
mrs r5, cpsr // copy cpsr register in r5
sub r0, r13, #52 // save original stack pointer in r0
mov r1, r14  // save link register
sub r2, r15, #24 //save original pc in r2
stmia r13!, {r0 - r2} // save sp, lr, pc
sub r13, r13, #64 //retrieve stack pointer
ldr r9, =string1 //store address of string1

mov r4, #0 //index of registerloop r4 = 0

bl registerloop //print string part and all registers in hex

bl trans_loop //print string part

and r6, r5, #0xf0000000 //leave nzcv part only of cpsr
mov r6, r6, LSR#28  //remove seven 0s in hex

bl trans_loop2 //print nzcv of cpsr register

bl trans_loop3 //print E A I F T, and ISETSTATE

bl trans_loop // print string part

bl trans_loop4 //print current mode and cpsr register in hex

bl trans_loop // print string part


mov r14, r1 // back up link register
mov r13, r0 // back up stack pointer
ldmia r13!, {r0 - r12} // back up r0 ~ r12 registers
sub r13, r13, #52 //back up stack pointer again

//debugging ends

	stmia r1!, {r2-r9} //
	ldmia r0!, {r2-r9} //

///debugging start

stmia r13!, {r0 - r12} // store r0 ~ r12 register in stack
mrs r5, cpsr // copy cpsr register in r5
sub r0, r13, #52 // save original stack pointer in r0
mov r1, r14  // save link register
sub r2, r15, #24 //save original pc in r2
stmia r13!, {r0 - r2} // save sp, lr, pc
sub r13, r13, #64 //retrieve stack pointer
ldr r9, =string1 //store address of string1

mov r4, #0 //index of registerloop r4 = 0

bl registerloop //print string part and all registers in hex

bl trans_loop //print string part

and r6, r5, #0xf0000000 //leave nzcv part only of cpsr
mov r6, r6, LSR#28  //remove seven 0s in hex

bl trans_loop2 //print nzcv of cpsr register

bl trans_loop3 //print E A I F T, and ISETSTATE

bl trans_loop // print string part

bl trans_loop4 //print current mode and cpsr register in hex

bl trans_loop // print string part


mov r14, r1 // back up link register
mov r13, r0 // back up stack pointer
ldmia r13!, {r0 - r12} // back up r0 ~ r12 registers
sub r13, r13, #52 //back up stack pointer again

//debugging ends

	stmia r1!, {r2-r9} //
	ldmia r0!, {r2-r9} //

///debugging start

stmia r13!, {r0 - r12} // store r0 ~ r12 register in stack
mrs r5, cpsr // copy cpsr register in r5
sub r0, r13, #52 // save original stack pointer in r0
mov r1, r14  // save link register
sub r2, r15, #24 //save original pc in r2
stmia r13!, {r0 - r2} // save sp, lr, pc
sub r13, r13, #64 //retrieve stack pointer
ldr r9, =string1 //store address of string1

mov r4, #0 //index of registerloop r4 = 0

bl registerloop //print string part and all registers in hex

bl trans_loop //print string part

and r6, r5, #0xf0000000 //leave nzcv part only of cpsr
mov r6, r6, LSR#28  //remove seven 0s in hex

bl trans_loop2 //print nzcv of cpsr register

bl trans_loop3 //print E A I F T, and ISETSTATE

bl trans_loop // print string part

bl trans_loop4 //print current mode and cpsr register in hex

bl trans_loop // print string part


mov r14, r1 // back up link register
mov r13, r0 // back up stack pointer
ldmia r13!, {r0 - r12} // back up r0 ~ r12 registers
sub r13, r13, #52 //back up stack pointer again

//debugging ends

	stmia r1!, {r2-r9} //
	ldmia r0!, {r2-r9} //

///debugging start

stmia r13!, {r0 - r12} // store r0 ~ r12 register in stack
mrs r5, cpsr // copy cpsr register in r5
sub r0, r13, #52 // save original stack pointer in r0
mov r1, r14  // save link register
sub r2, r15, #24 //save original pc in r2
stmia r13!, {r0 - r2} // save sp, lr, pc
sub r13, r13, #64 //retrieve stack pointer
ldr r9, =string1 //store address of string1

mov r4, #0 //index of registerloop r4 = 0

bl registerloop //print string part and all registers in hex

bl trans_loop //print string part

and r6, r5, #0xf0000000 //leave nzcv part only of cpsr
mov r6, r6, LSR#28  //remove seven 0s in hex

bl trans_loop2 //print nzcv of cpsr register

bl trans_loop3 //print E A I F T, and ISETSTATE

bl trans_loop // print string part

bl trans_loop4 //print current mode and cpsr register in hex

bl trans_loop // print string part


mov r14, r1 // back up link register
mov r13, r0 // back up stack pointer
ldmia r13!, {r0 - r12} // back up r0 ~ r12 registers
sub r13, r13, #52 //back up stack pointer again

//debugging ends

	stmia r1!, {r2-r9} //copy input_data to output data (4 times * 8 numbers)


outerloop:
 ldr r0, =Output_data //save address of output
 ldr r1, =Output_data //save address of output


loop:


	ldmia r0!, {r2-r9} //load 8 integers
	cmp r12, #0	// compare r12 and 0
	beq next	// if r12 == 0 go to next
	cmp r10,r2  // compare first number to last number of previous 8 integers
	blt next  // if first number is smaller
///debugging start

stmia r13!, {r0 - r12} // store r0 ~ r12 register in stack
mrs r5, cpsr // copy cpsr register in r5
sub r0, r13, #52 // save original stack pointer in r0
mov r1, r14  // save link register
sub r2, r15, #24 //save original pc in r2
stmia r13!, {r0 - r2} // save sp, lr, pc
sub r13, r13, #64 //retrieve stack pointer
ldr r9, =string1 //store address of string1

mov r4, #0 //index of registerloop r4 = 0

bl registerloop //print string part and all registers in hex

bl trans_loop //print string part

and r6, r5, #0xf0000000 //leave nzcv part only of cpsr
mov r6, r6, LSR#28  //remove seven 0s in hex

bl trans_loop2 //print nzcv of cpsr register

bl trans_loop3 //print E A I F T, and ISETSTATE

bl trans_loop // print string part

bl trans_loop4 //print current mode and cpsr register in hex

bl trans_loop // print string part


mov r14, r1 // back up link register
mov r13, r0 // back up stack pointer
ldmia r13!, {r0 - r12} // back up r0 ~ r12 registers
sub r13, r13, #52 //back up stack pointer again

//debugging ends
	sub r1, r1, #4 // r1 = r1-4
///debugging start

stmia r13!, {r0 - r12} // store r0 ~ r12 register in stack
mrs r5, cpsr // copy cpsr register in r5
sub r0, r13, #52 // save original stack pointer in r0
mov r1, r14  // save link register
sub r2, r15, #24 //save original pc in r2
stmia r13!, {r0 - r2} // save sp, lr, pc
sub r13, r13, #64 //retrieve stack pointer
ldr r9, =string1 //store address of string1

mov r4, #0 //index of registerloop r4 = 0

bl registerloop //print string part and all registers in hex

bl trans_loop //print string part

and r6, r5, #0xf0000000 //leave nzcv part only of cpsr
mov r6, r6, LSR#28  //remove seven 0s in hex

bl trans_loop2 //print nzcv of cpsr register

bl trans_loop3 //print E A I F T, and ISETSTATE

bl trans_loop // print string part

bl trans_loop4 //print current mode and cpsr register in hex

bl trans_loop // print string part


mov r14, r1 // back up link register
mov r13, r0 // back up stack pointer
ldmia r13!, {r0 - r12} // back up r0 ~ r12 registers
sub r13, r13, #52 //back up stack pointer again

//debugging ends

	str r2, [r1], #4 // swap first number for last number of previous 8 integers
	mov r2, r10		 // and add 4 to r1

next:
	cmp r2,r3 // if r2>r3
	blt next0 // if not, go to next0

    mov r10, r2 // swap r2 and r3
    mov r2, r3	// swap r2 and r3
    mov r3, r10 // swap r2 and r3
next0:
	cmp r3,r4 //if r3 > r4
	blt next1 //if not, go to next1

	mov r10, r3 // swap r3 and r4
	mov r3, r4  // swap r3 and r4
	mov r4, r10 // swap r3 and r4
next1:
	cmp r4,r5 // if r4 > r5
	blt next2 // if not, go to next2

	mov r10, r4 // swap r4 and r5
	mov r4, r5  // swap r4 and r5
	mov r5, r10 // swap r4 and r5
next2:
	cmp r5,r6 // if r5 > r6
	blt next3 // if not, go to next3
	mov r10, r5 // swap r5 and r6
	mov r5, r6  // swap r5 and r6
	mov r6, r10 // swap r5 and r6
next3:
	cmp r6,r7 // if r6 > r7
	blt next4 // if not, go to next4

	mov r10, r6 // swap r6 and r7
	mov r6, r7  // swap r6 and r7
	mov r7, r10 // swap r6 and r7
next4:
	cmp r7,r8 // if r7 > r8
	blt next5 // if not, go to next5

	mov r10, r7 //swap r7 and r8
	mov r7, r8  //swap r7 and r8
	mov r8, r10 //swap r7 and r8
next5:
	mov r10, r9 //store the last number in temp to compare it with first number of next 8 numbers
	cmp r8,r9 // if r8 > r9
	blt next6 // if not, go to next6

	mov r10, r8 // swap r8 and r9
	mov r8, r9  // swap r8 and r9
	mov r9, r10 // swap r8 and r9
next6:
	stmia r1!, {r2-r9} // store 8 numbers to memory
	add r12, r12, #1 // r12 increase 0 to 4
	cmp r12, #4		// to do 4 times which means 32 numbers
	bne loop // if r12 is not 4, go to loop again

	mov r12, #0 // set r12 to 0
	add r11, r11, #1 // increment r11
	cmp r11, #32 // r11 loops 32 times for bubble sort
	bne outerloop // if r11 - 32 is not 0, go to outerloop again


///debugging start

stmia r13!, {r0 - r12} // store r0 ~ r12 register in stack
mrs r5, cpsr // copy cpsr register in r5
sub r0, r13, #52 // save original stack pointer in r0
mov r1, r14  // save link register
sub r2, r15, #24 //save original pc in r2
stmia r13!, {r0 - r2} // save sp, lr, pc
sub r13, r13, #64 //retrieve stack pointer
ldr r9, =string1 //store address of string1

mov r4, #0 //index of registerloop r4 = 0

bl registerloop //print string part and all registers in hex

bl trans_loop //print string part

and r6, r5, #0xf0000000 //leave nzcv part only of cpsr
mov r6, r6, LSR#28  //remove seven 0s in hex

bl trans_loop2 //print nzcv of cpsr register

bl trans_loop3 //print E A I F T, and ISETSTATE

bl trans_loop // print string part

bl trans_loop4 //print current mode and cpsr register in hex

bl trans_loop // print string part


mov r14, r1 // back up link register
mov r13, r0 // back up stack pointer
ldmia r13!, {r0 - r12} // back up r0 ~ r12 registers
sub r13, r13, #52 //back up stack pointer again

//debugging ends


forever:
	nop
	b forever

registerloop:
mov r3, r14 //copy link register
bl trans_loop //print string part
mov r14, r3 //paste link register

ldr r11, [r13], #4 //load one register to r11 and increase stack pointer
bl trans_loop1 //print register part
mov r14, r3 //paste link register

add r4, r4, #1 //r4++
cmp r4, #16 //if (r0 ~ r15) 16 registers are printed
moveq pc, r14 // then go back
bne registerloop//else keep printing



trans_loop: // print string part

	ldr 	r10, =UART1_BASE


	// ---------  Check to see if the Tx FIFO is empty ------------------------------
	ldr 	r8, [r10, #UART_CHANNEL_STS_REG0_OFFSET]	//get channel status register
	and	r8, r8, #0x8		//transmitter FIFO status 0: not empty 1: empty
	cmp	r8, #0x8				// check if TxFIFO is empty and ready to receive new data
	bne	trans_loop		// if TxFIFO is NOT empty, keep checking until it is empty

	ldrb    r7, [r9], #1 //load one byte to r7 from r9 (string1)
	strb	r7, [r10, #UART_TX_RX_FIFO0_OFFSET]	@ fill the TxFIFO with 0x48 //store that byte to TxRx FIFO
	cmp     r7, #0x00 //compare r7 with null (end of string1)
	bne		trans_loop //if it is not null keep transmitting
	mov pc, lr

trans_loop1: // print value of register

	ldr 	r10, =UART1_BASE


	// ---------  Check to see if the Tx FIFO is empty ------------------------------
	ldr 	r8, [r10, #UART_CHANNEL_STS_REG0_OFFSET]	//get channel status register
	and	r8, r8, #0x8		//transmitter FIFO status 0: not empty 1: empty
	cmp	r8, #0x8				// check if TxFIFO is empty and ready to receive new data
	bne	trans_loop1		// if TxFIFO is NOT empty, keep checking until it is empty

	mov r7, #48 //print '0'
	str	r7, [r10, #UART_TX_RX_FIFO0_OFFSET]	@ fill the TxFIFO with 0x48

	mov r7, #120 //print 'x'
	str	r7, [r10, #UART_TX_RX_FIFO0_OFFSET]	@ fill the TxFIFO with 0x48


	mov    r7, r11
	and r7, r7, #0xf0000000 //first number
	mov r7, r7, LSR#28

	cmp r7, #10
	addlt r7, r7, #48//if r7 = 0,1,2,3,4,5,6,7,8,9
	strlt	r7, [r10, #UART_TX_RX_FIFO0_OFFSET]//store that byte to TxRx FIFO

	addge r7, r7, #87 //if r7 = a,b,c,d,e,f
	strge	r7, [r10, #UART_TX_RX_FIFO0_OFFSET]//store that byte to TxRx FIFO

	mov    r7, r11
	and r7, r7, #0x0f000000 //second number
	mov r7, r7, LSR#24

	cmp r7, #10
	addlt r7, r7, #48//if r7 = 0,1,2,3,4,5,6,7,8,9
	strlt	r7, [r10, #UART_TX_RX_FIFO0_OFFSET]//store that byte to TxRx FIFO

	addge r7, r7, #87 //if r7 = a,b,c,d,e,f
	strge	r7, [r10, #UART_TX_RX_FIFO0_OFFSET]//store that byte to TxRx FIFO

	mov    r7, r11
	and r7, r7, #0x00f00000 //third number
	mov r7, r7, LSR#20

	cmp r7, #10
	addlt r7, r7, #48//if r7 = 0,1,2,3,4,5,6,7,8,9
	strlt	r7, [r10, #UART_TX_RX_FIFO0_OFFSET]//store that byte to TxRx FIFO

	addge r7, r7, #87 //if r7 = a,b,c,d,e,f
	strge	r7, [r10, #UART_TX_RX_FIFO0_OFFSET]//store that byte to TxRx FIFO

	mov    r7, r11
	and r7, r7, #0x000f0000 //4th number
	mov r7, r7, LSR#16

	cmp r7, #10
	addlt r7, r7, #48//if r7 = 0,1,2,3,4,5,6,7,8,9
	strlt	r7, [r10, #UART_TX_RX_FIFO0_OFFSET]//store that byte to TxRx FIFO

	addge r7, r7, #87 //if r7 = a,b,c,d,e,f
	strge	r7, [r10, #UART_TX_RX_FIFO0_OFFSET]//store that byte to TxRx FIFO

	mov r7, #95 //print '_'
	str	r7, [r10, #UART_TX_RX_FIFO0_OFFSET]	@ fill the TxFIFO with 0x48

	mov    r7, r11
	and r7, r7, #0x0000f000 //5th number
	mov r7, r7, LSR#12

	cmp r7, #10
	addlt r7, r7, #48//if r7 = 0,1,2,3,4,5,6,7,8,9
	strlt	r7, [r10, #UART_TX_RX_FIFO0_OFFSET]//store that byte to TxRx FIFO

	addge r7, r7, #87 //if r7 = a,b,c,d,e,f
	strge	r7, [r10, #UART_TX_RX_FIFO0_OFFSET]//store that byte to TxRx FIFO

	mov    r7, r11
	and r7, r7, #0x00000f00 //6th number
	mov r7, r7, LSR#8

	cmp r7, #10
	addlt r7, r7, #48//if r7 = 0,1,2,3,4,5,6,7,8,9
	strlt	r7, [r10, #UART_TX_RX_FIFO0_OFFSET]//store that byte to TxRx FIFO

	addge r7, r7, #87 //if r7 = a,b,c,d,e,f
	strge	r7, [r10, #UART_TX_RX_FIFO0_OFFSET]//store that byte to TxRx FIFO

	mov    r7, r11
	and r7, r7, #0x000000f0 //7th number
	mov r7, r7, LSR#4

	cmp r7, #10
	addlt r7, r7, #48//if r7 = 0,1,2,3,4,5,6,7,8,9
	strlt	r7, [r10, #UART_TX_RX_FIFO0_OFFSET]//store that byte to TxRx FIFO

	addge r7, r7, #87 //if r7 = a,b,c,d,e,f
	strge	r7, [r10, #UART_TX_RX_FIFO0_OFFSET]//store that byte to TxRx FIFO

	mov    r7, r11
	and r7, r7, #0x0000000f //last, 8th number

	cmp r7, #10
	addlt r7, r7, #48//if r7 = 0,1,2,3,4,5,6,7,8,9
	strlt	r7, [r10, #UART_TX_RX_FIFO0_OFFSET]//store that byte to TxRx FIFO

	addge r7, r7, #87 //if r7 = a,b,c,d,e,f
	strge	r7, [r10, #UART_TX_RX_FIFO0_OFFSET]//store that byte to TxRx FIFO

	//mov r7, #44 //print ','      ->rather put ',' in string1
	//str	r7, [r10, #UART_TX_RX_FIFO0_OFFSET]

	mov r7, #32 //print space
	str	r7, [r10, #UART_TX_RX_FIFO0_OFFSET]

	mov pc, lr

trans_loop2: //print nzcv of cpsr

	ldr 	r10, =UART1_BASE


	// ---------  Check to see if the Tx FIFO is empty ------------------------------
	ldr 	r8, [r10, #UART_CHANNEL_STS_REG0_OFFSET]	//get channel status register
	and	r8, r8, #0x8		//transmitter FIFO status 0: not empty 1: empty
	cmp	r8, #0x8				// check if TxFIFO is empty and ready to receive new data
	bne	trans_loop2		// if TxFIFO is NOT empty, keep checking until it is empty


	and r7, r6, #0b1000
	cmp r7, #0
	moveq r7, #110 // print 'n'
	streq	r7, [r10, #UART_TX_RX_FIFO0_OFFSET]

	movne r7, #78 //print 'N'
	strne	r7, [r10, #UART_TX_RX_FIFO0_OFFSET]

	and r7, r6, #0b0100
	cmp r7, #0
	moveq r7, #122 // print 'z'
	streq	r7, [r10, #UART_TX_RX_FIFO0_OFFSET]

	movne r7, #90 //print 'Z'
	strne	r7, [r10, #UART_TX_RX_FIFO0_OFFSET]

	and r7, r6, #0b0010
	cmp r7, #0
	moveq r7, #99 // print 'c'
	streq	r7, [r10, #UART_TX_RX_FIFO0_OFFSET]

	movne r7, #67 //print 'C'
	strne	r7, [r10, #UART_TX_RX_FIFO0_OFFSET]

	and r7, r6, #0b0001
	cmp r7, #0
	moveq r7, #118 // print 'v'
	streq	r7, [r10, #UART_TX_RX_FIFO0_OFFSET]

	movne r7, #86 //print 'V'
	strne	r7, [r10, #UART_TX_RX_FIFO0_OFFSET]

	mov pc, lr


trans_loop3: //print mask bits and ISETSTATE

	ldr 	r10, =UART1_BASE


	// ---------  Check to see if the Tx FIFO is empty ------------------------------
	ldr 	r8, [r10, #UART_CHANNEL_STS_REG0_OFFSET]	//get channel status register
	and	r8, r8, #0x8		//transmitter FIFO status 0: not empty 1: empty
	cmp	r8, #0x8				// check if TxFIFO is empty and ready to receive new data
	bne	trans_loop3		// if TxFIFO is NOT empty, keep checking until it is empty

	mov r7, #44 // print ','
	str	r7, [r10, #UART_TX_RX_FIFO0_OFFSET]

	mov r7, #32 //print space
	str	r7, [r10, #UART_TX_RX_FIFO0_OFFSET]




	and r6, r5, #0b1000000000 //'E' register
	cmp r6, #0

	movne r7, #69 //if 'E' register is set
	strne	r7, [r10, #UART_TX_RX_FIFO0_OFFSET] //print 'E'

	and r6, r5, #0b100000000 //'A' register
	cmp r6, #0

	movne r7, #65 //if 'A' register is set
	strne	r7, [r10, #UART_TX_RX_FIFO0_OFFSET] //print 'A'

	and r6, r5, #0b10000000 //'I' register
	cmp r6, #0

	movne r7, #73 //if 'I' register is set
	strne	r7, [r10, #UART_TX_RX_FIFO0_OFFSET] //print 'I'

	and r6, r5, #0b1000000 //'F' register
	cmp r6, #0

	movne r7, #70 //if 'F' register is set
	strne	r7, [r10, #UART_TX_RX_FIFO0_OFFSET] //print 'F'


	and r6, r5, #0b100000 //'T' register
	cmp r6, #0

	movne r7, #84 //if 'T' register is set
	strne	r7, [r10, #UART_TX_RX_FIFO0_OFFSET] //print 'T'

	mov r7, #44 // print ','
	str	r7, [r10, #UART_TX_RX_FIFO0_OFFSET]

	mov r7, #32 //print space
	str	r7, [r10, #UART_TX_RX_FIFO0_OFFSET]

	and r6, r5, #0x1000000 // leave J bit
	and r4, r5, #0b100000 //leave T bit
	mov r6, r6, lsr#23
	mov r4, r4, lsr#5
	add r6, r4, r6 //make J T


	cmp r6, #0
	ldreq r12, =string2 //print "ARM mode"

	cmp r6, #0b01
	ldreq r12, =string3 //print "Thumb mode"

	cmp r6, #0b10
	ldreq r12, =string4 //print "Jazelle mode"

	cmp r6, #0b11
	ldreq r12, =string5 //print "ThumbEE mode"

	trans:
	ldrb    r7, [r12], #1
	strb	r7, [r10, #UART_TX_RX_FIFO0_OFFSET] //store that byte to TxRx FIFO
	cmp     r7, #0x00
	bne		trans

	mov pc, lr

	trans_loop4: // print current mode and cpsr register in hex

	and r6, r5, #0x1f // leave mode bits( last 5 bits) only

	cmp r6, #0b10000 //print "USER" user mode
	moveq r7, #85
	streq	r7, [r10, #UART_TX_RX_FIFO0_OFFSET]
	moveq r7, #83
	streq	r7, [r10, #UART_TX_RX_FIFO0_OFFSET]
	moveq r7, #69
	streq	r7, [r10, #UART_TX_RX_FIFO0_OFFSET]
	moveq r7, #82
	streq	r7, [r10, #UART_TX_RX_FIFO0_OFFSET]

	cmp r6, #0b10001 //print "FIQ" fiq mode
	moveq r7, #70
	streq	r7, [r10, #UART_TX_RX_FIFO0_OFFSET]
	moveq r7, #73
	streq	r7, [r10, #UART_TX_RX_FIFO0_OFFSET]
	moveq r7, #81
	streq	r7, [r10, #UART_TX_RX_FIFO0_OFFSET]

	cmp r6, #0b10010 //print "IRQ" irq mode
	moveq r7, #73
	streq	r7, [r10, #UART_TX_RX_FIFO0_OFFSET]
	moveq r7, #82
	streq	r7, [r10, #UART_TX_RX_FIFO0_OFFSET]
	moveq r7, #81
	streq	r7, [r10, #UART_TX_RX_FIFO0_OFFSET]

	cmp r6, #0b10011 //print "SVC" supervisor mode
	moveq r7, #82
	streq	r7, [r10, #UART_TX_RX_FIFO0_OFFSET]
	moveq r7, #86
	streq	r7, [r10, #UART_TX_RX_FIFO0_OFFSET]
	moveq r7, #67
	streq	r7, [r10, #UART_TX_RX_FIFO0_OFFSET]

	cmp r6, #0b10110 //print "MON" monitor mode
	moveq r7, #77
	streq	r7, [r10, #UART_TX_RX_FIFO0_OFFSET]
	moveq r7, #79
	streq	r7, [r10, #UART_TX_RX_FIFO0_OFFSET]
	moveq r7, #78
	streq	r7, [r10, #UART_TX_RX_FIFO0_OFFSET]

	cmp r6, #0b10111 //print "ABT" abort mode
	moveq r7, #65
	streq	r7, [r10, #UART_TX_RX_FIFO0_OFFSET]
	moveq r7, #66
	streq	r7, [r10, #UART_TX_RX_FIFO0_OFFSET]
	moveq r7, #84
	streq	r7, [r10, #UART_TX_RX_FIFO0_OFFSET]

	cmp r6, #0b11010 //print "HYP" hyp mode
	moveq r7, #72
	streq	r7, [r10, #UART_TX_RX_FIFO0_OFFSET]
	moveq r7, #89
	streq	r7, [r10, #UART_TX_RX_FIFO0_OFFSET]
	moveq r7, #80
	streq	r7, [r10, #UART_TX_RX_FIFO0_OFFSET]

	cmp r6, #0b11011 //print "UND" undefined mode
	moveq r7, #85
	streq	r7, [r10, #UART_TX_RX_FIFO0_OFFSET]
	moveq r7, #78
	streq	r7, [r10, #UART_TX_RX_FIFO0_OFFSET]
	moveq r7, #68
	streq	r7, [r10, #UART_TX_RX_FIFO0_OFFSET]

	cmp r6, #0b11111 //print "SYS" system mode
	moveq r7, #83
	streq	r7, [r10, #UART_TX_RX_FIFO0_OFFSET]
	moveq r7, #89
	streq	r7, [r10, #UART_TX_RX_FIFO0_OFFSET]
	moveq r7, #83
	streq	r7, [r10, #UART_TX_RX_FIFO0_OFFSET]

	mov r7, #32 //print space
	str	r7, [r10, #UART_TX_RX_FIFO0_OFFSET]

	mov r7, #40 //print '('
	str	r7, [r10, #UART_TX_RX_FIFO0_OFFSET]

	mov r7, #32 //print space
	str	r7, [r10, #UART_TX_RX_FIFO0_OFFSET]

	mov r7, #61 //print '='
	str	r7, [r10, #UART_TX_RX_FIFO0_OFFSET]

	mov r7, #48 //print '0'
	str	r7, [r10, #UART_TX_RX_FIFO0_OFFSET]	@ fill the TxFIFO with 0x48

	mov r7, #120 //print 'x'
	str	r7, [r10, #UART_TX_RX_FIFO0_OFFSET]	@ fill the TxFIFO with 0x48

	mov    r7, r5
	and r7, r7, #0xf0000000 //first number
	mov r7, r7, LSR#28

	cmp r7, #10
	addlt r7, r7, #48//if r7 = 0,1,2,3,4,5,6,7,8,9
	strlt	r7, [r10, #UART_TX_RX_FIFO0_OFFSET]//store that byte to TxRx FIFO

	addge r7, r7, #87 //if r7 = a,b,c,d,e,f
	strge	r7, [r10, #UART_TX_RX_FIFO0_OFFSET]//store that byte to TxRx FIFO

	mov    r7, r5
	and r7, r7, #0x0f000000 //second number
	mov r7, r7, LSR#24

	cmp r7, #10
	addlt r7, r7, #48//if r7 = 0,1,2,3,4,5,6,7,8,9
	strlt	r7, [r10, #UART_TX_RX_FIFO0_OFFSET]//store that byte to TxRx FIFO

	addge r7, r7, #87 //if r7 = a,b,c,d,e,f
	strge	r7, [r10, #UART_TX_RX_FIFO0_OFFSET]//store that byte to TxRx FIFO

	mov    r7, r5
	and r7, r7, #0x00f00000 //third number
	mov r7, r7, LSR#20

	cmp r7, #10
	addlt r7, r7, #48//if r7 = 0,1,2,3,4,5,6,7,8,9
	strlt	r7, [r10, #UART_TX_RX_FIFO0_OFFSET]//store that byte to TxRx FIFO

	addge r7, r7, #87 //if r7 = a,b,c,d,e,f
	strge	r7, [r10, #UART_TX_RX_FIFO0_OFFSET]//store that byte to TxRx FIFO

	mov    r7, r5
	and r7, r7, #0x000f0000 //4th number
	mov r7, r7, LSR#16

	cmp r7, #10
	addlt r7, r7, #48//if r7 = 0,1,2,3,4,5,6,7,8,9
	strlt	r7, [r10, #UART_TX_RX_FIFO0_OFFSET]//store that byte to TxRx FIFO

	addge r7, r7, #87 //if r7 = a,b,c,d,e,f
	strge	r7, [r10, #UART_TX_RX_FIFO0_OFFSET]//store that byte to TxRx FIFO

	mov r7, #95 //print '_'
	str	r7, [r10, #UART_TX_RX_FIFO0_OFFSET]	@ fill the TxFIFO with 0x48

	mov    r7, r5
	and r7, r7, #0x0000f000 //5th number
	mov r7, r7, LSR#12

	cmp r7, #10
	addlt r7, r7, #48//if r7 = 0,1,2,3,4,5,6,7,8,9
	strlt	r7, [r10, #UART_TX_RX_FIFO0_OFFSET]//store that byte to TxRx FIFO

	addge r7, r7, #87 //if r7 = a,b,c,d,e,f
	strge	r7, [r10, #UART_TX_RX_FIFO0_OFFSET]//store that byte to TxRx FIFO

	mov    r7, r5
	and r7, r7, #0x00000f00 //6th number
	mov r7, r7, LSR#8

	cmp r7, #10
	addlt r7, r7, #48//if r7 = 0,1,2,3,4,5,6,7,8,9
	strlt	r7, [r10, #UART_TX_RX_FIFO0_OFFSET]//store that byte to TxRx FIFO

	addge r7, r7, #87 //if r7 = a,b,c,d,e,f
	strge	r7, [r10, #UART_TX_RX_FIFO0_OFFSET]//store that byte to TxRx FIFO

	mov    r7, r5
	and r7, r7, #0x000000f0 //7th number
	mov r7, r7, LSR#4

	cmp r7, #10
	addlt r7, r7, #48//if r7 = 0,1,2,3,4,5,6,7,8,9
	strlt	r7, [r10, #UART_TX_RX_FIFO0_OFFSET]//store that byte to TxRx FIFO

	addge r7, r7, #87 //if r7 = a,b,c,d,e,f
	strge	r7, [r10, #UART_TX_RX_FIFO0_OFFSET]//store that byte to TxRx FIFO

	mov    r7, r5
	and r7, r7, #0x0000000f //last, 8th number

	cmp r7, #10
	addlt r7, r7, #48//if r7 = 0,1,2,3,4,5,6,7,8,9
	strlt	r7, [r10, #UART_TX_RX_FIFO0_OFFSET]//store that byte to TxRx FIFO

	addge r7, r7, #87 //if r7 = a,b,c,d,e,f
	strge	r7, [r10, #UART_TX_RX_FIFO0_OFFSET]//store that byte to TxRx FIFO

	mov r7, #41 //print ')'
	str	r7, [r10, #UART_TX_RX_FIFO0_OFFSET]

	mov pc, lr

.data
string1:
	.ascii "-------------------------------------------------------------------------"
	.byte 0x0D
	.byte 0x0A
	.ascii "r0 = "
	.byte 0x00
	.ascii ", r1 = "
	.byte 0x00
	.ascii ", r2 = "
	.byte 0x00
	.ascii ", r3 = "
	.byte 0x00
	.byte 0x0D
	.byte 0x0A
	.ascii "r4 = "
	.byte 0x00
	.ascii ", r5 = "
	.byte 0x00
	.ascii ", r6 = "
	.byte 0x00
	.ascii ", r7 = "
	.byte 0x00
	.byte 0x0D
	.byte 0x0A
	.ascii "r8 = "
	.byte 0x00
	.ascii ", r9 = "
	.byte 0x00
	.ascii ", r10 = "
	.byte 0x00
	.ascii ", r11 = "
	.byte 0x00
	.byte 0x0D
	.byte 0x0A
	.ascii "r12 = "
	.byte 0x00
	.ascii ", r13 = "
	.byte 0x00
	.ascii ", r14 = "
	.byte 0x00
	.ascii ", r15 = "
	.byte 0x00
	.byte 0x0D
	.byte 0x0A
	.ascii "cpsr = "
	.byte 0x00
	.ascii ", current mode = "
	.byte 0x00
	.byte 0x0D
	.byte 0x0A
	.ascii "-------------------------------------------------------------------------"
	.byte 0x0D
	.byte 0x0A
	.byte 0x00
string2:
	.ascii "ARM mode"
	.byte 0x00
string3:
	.ascii "Thumb mode"
	.byte 0x00
string4:
	.ascii "Jazelle mode"
	.byte 0x00
string5:
	.ascii "ThumbEE mode"
	.byte 0x00

.data
.align 4

Input_data: .word 2, 0, -7, -1, 3, 8, -4, 10
 			.word -9, -16, 15, 13, 1, 4, -3, 14
 			.word -8, -10, -15, 6, -13, -5, 9, 12
 			.word -11, -14, -6, 11, 5, 7, -2, -12

Output_data: .word 0, 0, 0, 0, 0, 0, 0, 0
 			 .word 0, 0, 0, 0, 0, 0, 0, 0
 			 .word 0, 0, 0, 0, 0, 0, 0, 0
 			 .word 0, 0, 0, 0, 0, 0, 0, 0

// Normal Interrupt Service Routine
csd_irq:
	b .

