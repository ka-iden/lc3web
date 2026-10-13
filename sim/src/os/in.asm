; in trap routine
;
; print a prompt, read a character into r0, and echo it to the display

.ORIG x04A0

	lea r0, Prompt
	puts

	getc
	out

	rti

Prompt .STRINGZ "Input a character> "
.END
