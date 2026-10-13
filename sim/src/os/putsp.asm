; putsp trap routine
;
; write the packed string starting at the address in r0 to the display

.ORIG x04E0

	st r7, SaveR7
	st r0, SaveR0
	st r1, SaveR1
	st r2, SaveR2
	st r3, SaveR3
	st r4, SaveR4
	st r5, SaveR5

	add r1, r0, #0

Loop
	ldr r0, r1, #0
	brz Done

	ld r2, LowMask
	and r3, r0, r2
	jsr OutChar

	; shift the high byte down into the low byte of r3
	ld r2, BitMask
	ld r4, One
	and r3, r3, #0
Shift
	and r5, r0, r2
	brz Skip
	add r3, r3, r4
Skip
	add r2, r2, r2
	brz OutHigh
	add r4, r4, r4
	brnzp Shift
OutHigh
	jsr OutChar

	add r1, r1, #1
	brnzp Loop

Done
	ld r0, SaveR0
	ld r1, SaveR1
	ld r2, SaveR2
	ld r3, SaveR3
	ld r4, SaveR4
	ld r5, SaveR5
	ld r7, SaveR7

	ret

; output the character in r3, preserves r7
OutChar
	st r7, SaveR7Out

	ldi r2, DSR
	brn Ready
	brnzp OutChar

Ready
	sti r3, DDR

	ld r7, SaveR7Out

	ret

SaveR7Out .BLKW #1

DDR       .FILL xFE06
DSR       .FILL xFE04

LowMask   .FILL x00FF
BitMask   .FILL x0100
One       .FILL #1

SaveR0    .BLKW #1
SaveR1    .BLKW #1
SaveR2    .BLKW #1
SaveR3    .BLKW #1
SaveR4    .BLKW #1
SaveR5    .BLKW #1
SaveR7    .BLKW #1

.END
