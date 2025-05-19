INCLUDE Irvine32.inc  ; Include Irvine32 library for I/O functions

.data
	msgX byte "Generated X: ",0  ; Message for displaying X value
	msgY byte "Generated Y: ",0  ; Message for displaying Y value
	mes3 byte "Result:",0        ; Label for displaying the result
	vrx dword 0                  ; Variable to store X value
	vry dword 0                  ; Variable to store Y value
	rez dd 0                     ; Variable to store the result

.code
	main PROC
	; Initialize random number generator
	call Randomize               ; Seed random number generator with system time
	
	; Generate random X value (range: 0-100)
	mov eax, 101                 ; Set upper limit (exclusive) for RandomRange
	call RandomRange             ; Generate random number from 0 to 100
	mov vrx, eax                 ; Store generated X value
	
	; Display generated X value
	mov edx, OFFSET msgX         ; Load message for X value
	call WriteString             ; Display message
	mov eax, vrx                 ; Load X value
	call WriteInt                ; Display X value
	call Crlf                    ; New line
	
	; Generate random Y value (range: 0-100)
	mov eax, 101                 ; Set upper limit (exclusive) for RandomRange
	call RandomRange             ; Generate random number from 0 to 100
	mov vry, eax                 ; Store generated Y value
	
	; Display generated Y value
	mov edx, OFFSET msgY         ; Load message for Y value
	call WriteString             ; Display message
	mov eax, vry                 ; Load Y value
	call WriteInt                ; Display Y value
	call Crlf                    ; New line
	
	; Initialize registers for calculation
	xor eax,eax                  ; Clear eax register
	mov edx,0                    ; Clear edx register (for division)
	
	; Calculate Y/2 for comparison
	mov eax,vry                  ; Move Y value to eax
	mov bx,2                     ; Set divisor to 2
	div bx                       ; Calculate Y/2 (result in ax)
	
	; Calculate X - Y/2 to determine which formula to use
	mov ebx,vrx                  ; Move X value to ebx
	cmp ebx,eax                  ; Compare X with Y/2
	jle con1                     ; Jump to con1 if X <= Y/2
	
	; If X > Y/2, calculate result = (Y - 2X) - Y + 123 = -2X + 123
	mov eax,vrx                  ; Move X value to eax
	mov ebx,2                    ; Set multiplier to 2
	mul ebx                      ; Calculate 2X
	mov ebx,eax                  ; Store 2X in ebx
	mov eax,123                  ; Set eax to 123
	sub eax,ebx                  ; Calculate 123 - 2X
	mov rez,eax                  ; Store result
	jmp ex                       ; Jump to exit section
	
	; If X <= Y/2, calculate result = 2X - 153 + Y
	con1: mov eax,vrx            ; Move X value to eax
	mov ebx,2                    ; Set multiplier to 2
	mul ebx                      ; Calculate 2X
	sub eax,153                  ; Subtract 153 from 2X
	add eax,vry                  ; Add Y to the result
	mov rez,eax                  ; Store result
	
	; Display the result
	ex: mov edx,OFFSET mes3      ; Load address of result message
	call WriteString             ; Display "Result:" message
	mov eax,rez                  ; Move result to eax for display
	call WriteInt                ; Display the integer result
	call Crlf                    ; Add a new line
	exit                         ; Exit the program
	main ENDP
	END main