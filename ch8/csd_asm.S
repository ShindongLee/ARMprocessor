#include "csd_zynq_peripherals.h"

.extern csd_main

.section .csd_boot,"ax"

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

	// Set VBAR (Vector Base Address Register) to my own interrupt vectors
   ldr     r0, =csd_entry
   mcr     p15, 0, r0, c12, c0, 0
   dsb
   isb

	// Read Cache Type Register (CTR)
	mrc p15, 0, r1, c0, c0, 1

	// Read Cache Level ID Register (CLIDR)
	mrc p15, 1, r2, c0, c0, 1

ldr r9, =0x41200000 //LED address
mov r10, #0xC3 //11000011
mov r11, #0x3C //00111100
str r10, [r9]  //turn on 11000011 LED

ldr r8, =0x41210000 //Switch address

loop:
	ldr r4, [r8] //load switch input
	and r4, r4, #0x01 //leave lsb only
	cmp r4, #1 //compare with 1 (check SW0 input)

	bleq enable //if SW0 is on, enable cache
	blne disable//if SW0 is off, disable cache

	bl csd_main //wait while counting
	str r11, [r9]//turn on 00111100


	ldr r4, [r8] //load switch input
	and r4, r4, #0x01 //leave lsb only
	cmp r4, #1 //compare with 1 (check SW0 input)

	bleq enable //if SW0 is on, enable cache
	blne disable //if SW0 is off, disable cache

	bl csd_main //wait while counting
	str r10, [r9] //turn on 11000011

	b loop // loop again


disable:
	@------------------------
	@ Disable Caches (L2)
	@------------------------
	ldr r0, =L2_reg1_ctrl
    mov r1, #0x0
    str r1, [r0]
	@------------------------
	@ Disable Caches (IL1, DL1)
	@------------------------
	mrc		p15, 0, r0, c1, c0, 0	@ read control register (CP15 register1)
	bic		r0, r0, #4096		    @ disable I bit (Instruction Cache)
	bic		r0, r0, #4		        @ disable C bit (Data and Unified Caches)
	mcr		p15, 0, r0, c1, c0, 0	@ write control register (CP15 register2)
	mov pc, lr


enable:
	@------------------------
	@ Enable Caches (L2)
	@------------------------
	ldr r0, =L2_reg1_ctrl
    mov r1, #0x1
    str r1, [r0]

	@------------------------
	@ Enable Caches (IL1, DL1)
	@------------------------
	mrc		p15, 0, r0, c1, c0, 0	@ read control register (CP15 register1)
	orr		r0, r0, #(1<<12)	    @ Enable I bit (Instruction Cache)
	orr		r0, r0, #(1<<2)         @ Enable C bit (Data and Unified Caches)
	mcr		p15, 0, r0, c1, c0, 0	@ write control register (CP15 register2)
	mov pc, lr

forever:
	nop
	b forever

// Normal Interrupt Service Routine
csd_irq:
	b .

.end
