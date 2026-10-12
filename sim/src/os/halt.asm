; halt trap routine
;
; print a message and clear the running bit of the machine control register

.ORIG x0520

	st r7, SaveR7
	st r1, SaveR1
	st r0, SaveR0

	lea r0, Message
	puts

	ldi r1, MCRPtr
	ld r0, ClearMask
	and r0, r1, r0
	sti r0, MCRPtr

	ld r0, SaveR0
	ld r1, SaveR1
	ld r7, SaveR7

	ret

SaveR0    .BLKW #1
SaveR1    .BLKW #1
SaveR7    .BLKW #1

Message   .STRINGZ "\n----- Halting the processor ----- \n"
MCRPtr    .FILL xFFFE
ClearMask .FILL x7FFF

.END
