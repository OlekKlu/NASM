;OlekKlu

SYS_EXIT  equ 1
SYS_READ  equ 3
SYS_WRITE equ 4 
STDIN 	  equ 0
STDOUT    equ 1

section	.text

section	.data

msg db 'this is "Modulo" calculator', 0xA,0xD 
len equ $ - msg 
msg1 db 'Enter 1st number: ' , 0xA, 0xD  
len1 equ $ - msg1   

msg2 db 'Enter 2nd number: ' , 0xA, 0xD
len2 equ $ - msg2

msg3 db 'Remainder is: ' , 0xA, 0xD  
len3 equ $ - msg3

section .bss
val1 resb 2
val2 resb 2
res resb 1  


global _start    

section .text  
_start:

	; Display the message
    MOV eax, SYS_WRITE
    MOV ebx, STDOUT
    MOV ecx, msg
    MOV edx, len
    INT 80h
	
    
    MOV eax, SYS_WRITE
    MOV ebx, STDOUT
    MOV ecx, msg1 
    MOV edx, len1
    INT 0x80
    
    MOV eax, SYS_READ
    MOV ebx, STDIN
    MOV ecx, val1
    MOV edx, 2
    INT 0x80

    
    MOV eax, SYS_WRITE 
    MOV ebx, STDOUT
    MOV ecx, msg2
    MOV edx, len2 
    INT 0x80
    
    MOV eax, SYS_READ
    MOV ebx, STDIN 
    MOV ecx, val2
    MOV edx, 2
    INT 0x80

    ; Ascii 
    MOV al, [val1]
    SUB al, '0'  

    MOV bl, [val2]
    SUB bl, '0'
    
    ; mod
    MOV ah, 0
    div bl  
    MOV al, ah

    ADD al, '0'
    MOV [res], al

    
    MOV eax, SYS_WRITE
    MOV ebx, STDOUT  
    MOV ecx, msg3  
    MOV edx, len3
    INT 0x80 

    MOV eax, SYS_WRITE
    MOV ebx, STDOUT
    MOV ecx, res  
    MOV edx, 1
    INT 0x80

    ; SYS_EXIT  
    MOV eax, SYS_EXIT
    xor ebx, ebx
    INT 0x80
