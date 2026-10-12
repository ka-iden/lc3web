; unknown trap routine
;
; halts

.ORIG x0560

	st r7, SaveR7
	st r0, SaveR0

	halt

	ld r0, SaveR0
	ld r7, SaveR7

	ret

SaveR0  .BLKW #1
SaveR7  .BLKW #1

.END
