	.macro write_ecc rd rs1 rs2
	.insn   r 0x5b, 0x1, 0, \rd, \rs1, \rs2
	.endm

	.macro fix_ecc rd rs1 rs2
	.insn   r 0x5b, 0x5, 0, \rd, \rs1, \rs2
	.endm
