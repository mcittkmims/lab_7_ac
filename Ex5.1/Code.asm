INCLUDE Irvine32.inc 
.data
    array DWORD 4, 2, 5, 1, 9, 3, 8, 6  ; Array with even number of elements
    arraySize = ($ - array) / TYPE array
    
    promptBefore BYTE "Array before exchange: ", 0
    promptAfter BYTE "Array after exchange: ", 0
    
.code
main PROC
    ; Display the original array
    mov edx, OFFSET promptBefore
    call WriteString
    call DisplayArray
    
    ; Exchange pairs of values
    mov esi, 0                  ; Index for array
    mov ecx, arraySize / 2      ; Loop counter (half the array size for pairs)
    
Exchange_Loop:
    mov eax, array[esi]                     ; Get first element of pair
    mov ebx, array[esi + TYPE array]        ; Get second element of pair
    
    ; Swap the values
    mov array[esi], ebx                     ; First position gets second element
    mov array[esi + TYPE array], eax        ; Second position gets first element
    
    ; Move to the next pair
    add esi, 2 * TYPE array                 ; Move to next pair (skip 2 elements)
    
    loop Exchange_Loop
    
    ; Display the modified array
    call Crlf
    mov edx, OFFSET promptAfter
    call WriteString
    call DisplayArray
    
    exit
main ENDP

; Procedure to display the array
DisplayArray PROC
    push ecx                ; Save registers
    push esi
    
    mov esi, 0              ; Index for array
    mov ecx, arraySize      ; Loop counter
    
Display_Loop:
    mov eax, array[esi]     ; Get the current element
    call WriteDec           ; Display it
    mov al, ' '             ; Space separator
    call WriteChar
    
    add esi, TYPE array     ; Move to the next element
    
    loop Display_Loop
    
    call Crlf               ; New line
    
    pop esi                 ; Restore registers
    pop ecx
    ret
DisplayArray ENDP

END main