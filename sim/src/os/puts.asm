; puts trap routine
;
; write the null terminated string starting at the address in r0 to the display

.ORIG x0460

	st r0, SaveR0
	st r1, SaveR1
	st r2, SaveR2

Loop
	ldr r1, r0, #0
	brz Done

Poll
	ldi r2, DSR
	brzp Poll
	sti r1, DDR
	add r0, r0, #1
	brnzp Loop

Done
	ld r0, SaveR0
	ld r1, SaveR1
	ld r2, SaveR2

	rti

DSR    .FILL xFE04
DDR    .FILL xFE06

SaveR0 .BLKW #1
SaveR1 .BLKW #1
SaveR2 .BLKW #1

.END
