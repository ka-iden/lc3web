; getc trap routine
;
; poll keyboard status register and read a character from the keyboard data
; register into r0

.ORIG x03E0

Poll
	ldi r0, KBSR
	brzp Poll
	ldi r0, KBDR

	rti

KBSR   .FILL xFE00
KBDR   .FILL xFE02

.END
