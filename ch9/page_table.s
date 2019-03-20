
.globl  csd_PAGEtable
.section .csd_page_tbl, "a"

csd_PAGEtable:

.set PAGE, 0x400000 //0x400000
.word	PAGE + 0x576		/* S=b1 TEX=b101 AP=b11, C=b0, B=b1 */
.set	PAGE, PAGE+0x1000 //PAGE, PAGE+0x2000 for Figure 3
.word	PAGE + 0x576		/* S=b1 TEX=b101 AP=b11, C=b0, B=b1 */
.set	PAGE, PAGE+0x1000 //PAGE, 0x400000 for Figure 3
.word	PAGE + 0x576		/* S=b1 TEX=b101 AP=b11, C=b0, B=b1 */
.end
