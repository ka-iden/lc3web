; putsp trap routine
;
; write the packed string starting at the address in r0 to the display, two
; characters per word. A word with a zero low byte terminates the string, a
; word with a zero high byte terminates the string after its low byte is written

.ORIG x04E0

	st r7, SaveR7
	st r0, SaveR0
	st r1, SaveR1
	st r2, SaveR2
	st r3, SaveR3

	add r1, r0, #0

Loop
	ldr r0, r1, #0
	brz Done
	jsr OutChar
	ld r2, Mask
	and r0, r0, r2
	brz Done
	add r1, r1, #1
	brnzp Loop

Done
	ld r0, Zero
	jsr OutChar

	ld r0, SaveR0
	ld r1, SaveR1
	ld r2, SaveR2
	ld r3, SaveR3
	ld r7, SaveR7

	ret

; output the character in r0, preserves r7
OutChar
	st r7, SaveR7Out

	ldi r3, DSR
	brn Ready
	brnzp OutChar

Ready
	sti r0, DDR

	ld r7, SaveR7Out

	ret

SaveR7Out .BLKW #1

DDR       .FILL xFE06
DSR       .FILL xFE04

Mask      .FILL xFF00
Zero      .FILL #0

SaveR0    .BLKW #1
SaveR1    .BLKW #1
SaveR2    .BLKW #1
SaveR3    .BLKW #1
SaveR7    .BLKW #1

.END
