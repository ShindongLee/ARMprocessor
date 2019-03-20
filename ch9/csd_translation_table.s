
.globl  csd_MMUTable
.section .csd_mmu_tbl,"a"

csd_MMUTable:

.set SECT, 0
.word	SECT + 0x15de6		/* S=b1 TEX=b101 AP=b11, Domain=b1111, C=b0, B=b1 */
.set	SECT, SECT+0x100000
.word	SECT + 0x15de6		/* S=b1 TEX=b101 AP=b11, Domain=b1111, C=b0, B=b1 */
.set	SECT, SECT+0x100000
.word	csd_PAGEtable + 0x1e1		/* page table base address, Domain=0b1111, Last 2 bits are 01 */
.end
