
.align 8
// Our interrupt vector table
csd_entry:
	b csd_reset
	b .
	b .
	b csd_prefetch_abort
	b csd_data_abort
	b .
	b csd_irq
	b .
.global main
csd_reset:
main:

	// Set VBAR (Vector Base Address Register) to my own interrupt vectors
    ldr     r0, =csd_entry
    mcr     p15, 0, r0, c12, c0, 0

	// read SCTLR (System Control Register) to r0
	mrc	p15, 0, r0, c1, c0, 0

	// read SCR (Secure Configuration Register) to r1
	mrc p15, 0, r1, c1, c1, 0

	// read TTBCR (Translation Table Base Control Register) to r2
	mrc p15, 0, r2, c2, c0, 2

	// read TTBR0 to r3
	mrc p15, 0, r3, c2, c0, 0

	// read DACR (Domain Access Control Register) to r4
	mrc p15, 0, r4, c3, c0, 0

	/* Disable MMU, if enabled */
	mrc	p15, 0, r0, c1, c0, 0		/* read CP15 register 1 */
	bic	r0, r0, #0x1			/* clear bit 0 */
	mcr	p15, 0, r0, c1, c0, 0		/* write value back */

//Memory initialization
	ldr r0, =0x400000 //first address is 0x400000
	mov r1, #0 //r1 = 0
	mov r7, #1024 //r7 = 1024
   	sub r1, r1, r7 //r1 = r1- r7 = -1024
    mov r2, #0 // index = 0
    ldr r3, =3072 // loop 3072 times (1024*3)

    loop:
    str r1, [r0], #4 // store r1 in r0 address and add 4 to r0
    add r1, r1, #1 //increase value by 1 (-1024, -1023,... 2047)
    add r2, r2, #1 //increase index by 1
    cmp r2, r3 //if i=3072
    bne loop //then break, else loop again


	ldr	r0,=csd_MMUTable	   /* Load MMU translation table base */
	orr	r0, r0, #0x5B			/* Outer-cacheable, WB */
	mcr	15, 0, r0, c2, c0, 0		/* TTBR0 */


	/* Enable mmu, icahce and dcache */
	// read SCTLR (System Control Register) to r0
	mrc	p15, 0, r0, c1, c0, 0
	bic r0, r0, #(1<<12)  // I-bit = I$ disable
	bic r0, r0, #(1<<2)   // C-bit = $ disable
	orr r0, r0, #(1<<0)   // M-bit = MMU enable
	mcr	p15, 0, r0, c1, c0, 0	/* Enable cache and MMU */
	dsb					        /* dsb	allow the MMU to start up */
	isb					        /* isb	flush prefetch buffer */



	// read SCTLR (System Control Register) to r0
	mrc	p15, 0, r0, c1, c0, 0

	bl addition //add every integers in VA 0x200000~ 0x2020000



forever:
	nop
	b forever

addition:
	ldr r0, =0x200000 //first address is 0x200000
	mov r2, #0 //index = 0
	ldr r3, =3072 //add_loop 3072 times
	mov r9, #0 //return value (sum of all numbers)

	add_loop:
		ldr r1, [r0], #4 //load number from r0 address to r1 and add 4 to r0
		add r9, r9, r1 //sum = sum + r1
		add r2, r2, #1 //index++
		cmp r2, r3 //if index = 3072
		bne add_loop // then break, else loop again

	mov pc, lr


// Normal Interrupt Service Routine
csd_irq:
	b .

csd_prefetch_abort:
	mrc p15, 0, r10, c6, c0, 2  // read IFAR to r10
	mrc p15, 0, r11, c5, c0, 1  // read IFSR to r11
	b .

csd_data_abort:
	mrc p15, 0, r10, c6, c0, 0  // read DFAR to r10
	mrc p15, 0, r11, c5, c0, 0  // read DFSR to r11
	b .
