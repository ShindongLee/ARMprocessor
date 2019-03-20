#define csd_LED_ADDR	0x41200000

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


	mov r10, #0 //use r10 as a temp
	mov r11, #0 //use r11 as i of outerloop
	mov r12, #0 //use r12 as j of loop



	ldr r0, =Input_data //save address of input
	ldr r1, =Output_data//save address of output

	ldmia r0!, {r2-r9} //
	stmia r1!, {r2-r9} //
	ldmia r0!, {r2-r9} //
	stmia r1!, {r2-r9} //
	ldmia r0!, {r2-r9} //
	stmia r1!, {r2-r9} //
	ldmia r0!, {r2-r9} //
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
	sub r1, r1, #4 // r1 = r1-4
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


bl csd_main


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
