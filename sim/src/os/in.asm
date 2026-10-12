; in trap routine
;
; print a prompt, read a character into r0, and echo it to the display

.ORIG x04A0

	st r7, SaveR7

	lea r0, Prompt
	puts

	getc
	out

	ld r7, SaveR7

	ret

SaveR7 .FILL x3001 ; ???

Prompt .STRINGZ "Input a character> "
.END
