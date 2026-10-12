; out trap routine
;
; write the character in r0 to the display

.ORIG x0430

	st r7, SaveR7
	st r1, SaveR1

Poll
	ldi r1, DSR
	brzp Poll
	sti r0, DDR

	ld r1, SaveR1
	ld r7, SaveR7

	ret

DSR    .FILL xFE04
DDR    .FILL xFE06

SaveR1 .BLKW #1
SaveR7 .BLKW #1

.END
