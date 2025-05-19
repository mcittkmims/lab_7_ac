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
	
	; Calculate 2*Y for comparison
	mov eax,vry                  ; Move Y value to eax
	mov bx,2                     ; Set multiplier to 2
	mul bx                       ; Calculate 2*Y
	
	; Compare X with 2*Y to determine which formula to use
	cmp vrx,eax                  ; Compare X with 2*Y
	jb con1                      ; Jump to con1 if X < 2*Y
	
	; If X >= 2*Y, calculate result = 2*Y - 60
	mov eax,vry                  ; Move Y value to eax
	mov bx,2                     ; Set multiplier to 2
	mul bx                       ; Calculate 2*Y again
	sub eax,60                   ; Subtract 60 from 2*Y
	mov rez,eax                  ; Store result
	jmp ex                       ; Jump to exit section
	
	; If X < 2*Y, calculate result = X/8 + 32 - Y
	con1: mov eax,vrx            ; Move X value to eax
	mov bx,8                     ; Set divisor to 8
	div bx                       ; Divide X by 8 (result in ax)
	add eax,32                   ; Add 32 to X/8
	sub eax,vry                  ; Subtract Y
	mov rez,eax                  ; Store result
	
	; Display the result
	ex: mov edx,OFFSET mes3      ; Load address of result message
	call WriteString             ; Display "Result:" message
	call WriteInt                ; Display the integer result
	call Crlf                    ; Add a new line
	exit                         ; Exit the program
	main ENDP
	END main