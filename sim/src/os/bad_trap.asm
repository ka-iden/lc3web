; unknown trap routine
;
; halts

.ORIG x0560

	st r0, SaveR0

	halt

	ld r0, SaveR0

	rti

SaveR0  .BLKW #1

.END
