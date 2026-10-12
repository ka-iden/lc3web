; unknown trap routine
;
; prints nothing and halts

.ORIG xFD00 ; ???

	st r7, SaveR7
	st r0, SaveR0

	ld r0, BadChar ; ???
	out

	lea r0, BadMsg ; ???
	puts

	halt

	ld r0, SaveR0 ; ???
	ld r7, SaveR7

	ret

BadChar .BLKW #1
BadMsg  .BLKW #51 ; ???
SaveR0  .BLKW #1
SaveR7  .BLKW #1

.END
