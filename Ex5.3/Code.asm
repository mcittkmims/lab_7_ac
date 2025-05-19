INCLUDE Irvine32.inc

.data
buffer BYTE 100 DUP(0)  ; Buffer for random string storage
strMsg BYTE "Random string: ", 0
strLen DWORD 10         ; Default length for our random strings

.code
main PROC
    mov ecx, 20         ; Generate 20 strings

generate_loop:
    ; Display message prefix
    mov edx, OFFSET strMsg
    call WriteString
    
    ; Set up parameters for RandomString
    mov eax, strLen     ; String length in EAX
    lea esi, buffer     ; Buffer pointer in ESI
    call RandomString
    
    ; Display the generated string
    mov edx, OFFSET buffer
    call WriteString
    call Crlf
    
    loop generate_loop
    
    exit
main ENDP

RandomString PROC
    ; Input: EAX = length of string, ESI = pointer to buffer
    push ecx            ; Save registers
    push edx
    push esi
    
    mov ecx, eax        ; Initialize counter with requested length

generate_char:
    ; Generate random number between 0 and 25
    mov eax, 26         ; Range is 0 to 25 (for A-Z)
    call RandomRange
    
    ; Convert to capital letter (ASCII 65-90)
    add al, 'A'
    
    ; Store in buffer
    mov [esi], al
    inc esi             ; Move to next position in buffer
    
    loop generate_char
    
    ; Add null terminator
    mov BYTE PTR [esi], 0
    
    pop esi             ; Restore registers
    pop edx
    pop ecx
    ret
RandomString ENDP

END main
