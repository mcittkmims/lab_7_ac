INCLUDE Irvine32.inc  ; Include Irvine32 library for I/O functions

.data
	mes1 byte "Enter the X:",0    ; Prompt message for X input
	mes2 byte "Enter the Y:",0    ; Prompt message for Y input
	mes3 byte "Result:",0         ; Label for displaying the result
	vrx dword 0                  ; Variable to store X value
	vry dword 0                  ; Variable to store Y value
	rez dd 0                     ; Variable to store the result

.code
	main PROC
	; Prompt and get X value
	mov edx,OFFSET mes1          ; Load address of first message
	call WriteString             ; Display "Enter the X:" message
	call ReadDec                 ; Read decimal input from user
	mov vrx,eax                  ; Store X value in vrx variable
	
	; Prompt and get Y value
	mov edx,OFFSET mes2          ; Load address of second message
	call WriteString             ; Display "Enter the Y:" message
	call ReadDec                 ; Read decimal input from user
	mov vry,eax                  ; Store Y value in vry variable
	
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