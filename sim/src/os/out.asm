; out trap routine
;
; write the character in r0 to the display

.ORIG x0420

	st r1, SaveR1

Poll
	ldi r1, DSR
	brzp Poll
	sti r0, DDR

	ld r1, SaveR1

	rti

DSR    .FILL xFE04
DDR    .FILL xFE06

SaveR1 .BLKW #1

.END
