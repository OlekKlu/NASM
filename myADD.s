;OlekKlu

SYS_EXIT  equ 1
SYS_READ  equ 3
SYS_WRITE equ 4
STDIN     equ 0
STDOUT    equ 1

segment .data

    msg db 'this is "Add" calculator', 0xA,0xD 
    len equ $ - msg

    msg1 db 'Please enter the 1st number',  0xA,0xD 
    len1 equ $ - msg1
    
    msg2 db 'Please enter the 2st number',  0xA,0xD 
    len2 equ $ - msg2
    
    msg3 db 'The result is',  0xA,0xD 
    len3 equ $ - msg3
    
segment .bss

    val1 resb 2; change
    val2 resb 2
    res resb 1
    
    

section .text

global _start
_start :
    MOV eax, SYS_WRITE ; this is add calc
    MOV ebx, STDOUT
    MOV ecx, msg
    MOV edx, len
    INT 80h
    
    MOV eax, SYS_WRITE ; please enter the 1st
    MOV ebx, STDOUT
    MOV ecx, msg1
    MOV edx, len1
    INT 80h
    
    MOV eax, SYS_READ  ;read val1
    MOV ebx, STDIN
    MOV ecx, val1
    MOV edx, 2
    INT 80h
    
    MOV eax, SYS_WRITE ;please enter the 2nd
    MOV ebx, STDOUT
    MOV ecx, msg2
    MOV edx, len2
    INT 80h
    
    MOV eax, SYS_READ ;read val2
    MOV ebx, STDIN
    MOV ecx, val2
    MOV edx, 2
    INT 80h
    
    MOV eax, SYS_WRITE ;write res
    MOV ebx, STDOUT
    MOV ecx, msg3
    MOV edx, len3
    INT 80h
    
    ;ASCII coverter
    MOV eax, [val1]
    SUB eax, '0'
    
    MOV ebx, [val2]
    SUB ebx, '0'
    
    ;Main opp
    ADD eax, ebx
    ADD eax, '0'
    MOV [res], eax
    
    ;Print
    mov eax, SYS_WRITE        
    mov ebx, STDOUT
    MOV ecx, res
    MOV edx, 1
    INT 80h
    
    
    MOV eax, SYS_EXIT
    XOR ebx, ebx
    INT 80h
