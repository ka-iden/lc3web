; getc trap routine
;
; poll keyboard status register and read a character from the keyboard data
; register into r0

.ORIG x03E0

	st r7, SaveR7

Poll
	ldi r0, KBSR
	brzp Poll
	ldi r0, KBDR

	ld r7, SaveR7

	ret

KBSR   .FILL xFE00
KBDR   .FILL xFE02

SaveR7 .BLKW #1

.END
