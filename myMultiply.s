;OlekKLu

SYS_EXIT  equ 1
SYS_READ  equ 3
SYS_WRITE equ 4
STDIN     equ 0
STDOUT    equ 1

section .data
    msg db 'this is Multiply calculator', 0xA,0xD 
    len equ $ - msg

    msg1 db 'Please enter the 1st number',  0xA,0xD 
    len1 equ $ - msg1
    
    msg2 db 'Please enter the 2nd number',  0xA,0xD 
    len2 equ $ - msg2
    
    msg3 db 'The result is',  0xA,0xD 
    len3 equ $ - msg3
    
section .bss
    val1 resb 8
    val2 resb 8
    res  resb 2 
    
section .text
global _start

_start:
    ; Display the message
    MOV eax, SYS_WRITE
    MOV ebx, STDOUT
    MOV ecx, msg
    MOV edx, len
    INT 80h
    
    ; Please enter the 1st number
    MOV eax, SYS_WRITE
    MOV ebx, STDOUT
    MOV ecx, msg1
    MOV edx, len1
    INT 80h
    
    ; Read val1
    MOV eax, SYS_READ
    MOV ebx, STDIN
    MOV ecx, val1
    MOV edx, 8
    INT 80h
    
    ; Please enter the 2nd number
    MOV eax, SYS_WRITE
    MOV ebx, STDOUT
    MOV ecx, msg2
    MOV edx, len2
    INT 80h
    
    ; Read val2
    MOV eax, SYS_READ
    MOV ebx, STDIN
    MOV ecx, val2
    MOV edx, 8
    INT 80h
    
    ; Write "The result is"
    MOV eax, SYS_WRITE
    MOV ebx, STDOUT
    MOV ecx, msg3
    MOV edx, len3
    INT 80h
    
    ; ASCII converter
    MOV eax, [val1]
    SUB eax, '0'
    
    MOV ebx, [val2]
    SUB ebx, '0'
    
    
   
    ; Main operation (IMUL)
    IMUL ebx; single bite  instruction
    
    

    ADD eax, '0'
    MOV [res], eax
    
    ; Print the result
    MOV eax, SYS_WRITE
    MOV ebx, STDOUT
    MOV ecx, res
    MOV edx, 1 ; 
    INT 80h
    
    ; Exit the program
    MOV eax, SYS_EXIT
    XOR ebx, ebx
    INT 80h