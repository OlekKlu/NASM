;OlekKlu
; edition inplemented a uncond. jump to loop the programm
;NOTE tryout CALL / RET aproach next time
;ACII conv need to be perfomed with cond j and sep label to save space

SYS_EXIT  equ 1
SYS_READ  equ 3
SYS_WRITE equ 4
STDIN     equ 0
STDOUT    equ 1

section	.data

msgG	db	0xa,'This is second version of calculator',0xa	;our dear string
lenG	equ	$ - msgG			;General



msg1	db	0xa,'Please enter the 1st num:',0xa	;1st num
len1	equ	$ - msg1			;length of  string

msg2	db	'Please enter the 2nd num:',0xa	;our dear string
len2	equ	$ - msg2			;length of  string

msg3	db	'Result is:',0xa	
len3	equ	$ - msg3			

msg4	db	'Good bye!',0xa	
len4	equ	$ - msg4			

msgA	db	'press 1 for ADDition',0xa	
lenA	equ	$ - msgA			

msgS	db	'press 2 for SUBstraction',0xa	
lenS	equ	$ - msgS			

msgD	db	'press 3 for DIVision',0xa	
lenD	equ	$ - msgD			

msgM	db	'press 4 for Multiply',0xa	
lenM	equ	$ - msgM			

msgMo	db	'press 5 to Modulo',0xa	
lenMo	equ	$ - msgMo			

msgI	db	'press 6 to Increment',0xa	
lenI	equ	$ - msgI			

msgDe	db	'press 7 to Decrement',0xa	
lenDe	equ	$ - msgDe			

msgEx	db	'press 8 to Exit',0xa	
lenEx	equ	$ - msgEx	


msgExO	db	0xa,'press 8 to exit or any different number to continue',0xa	
lenExO	equ	$ - msgExO	





section .bss
    opt  resb 2
    val1 resb 2
    val2 resb 2
    opt2 resb 2
    res  resb 2
    res2 resb 2
    ck   resb 2; checker for primitive debug without gdb

section	.text
global _start       
_start:                     
; Display the message
    MOV eax, SYS_WRITE
    MOV ebx, STDOUT
    MOV ecx, msgG
    MOV edx, lenG
    INT 80h
loop1:  
    MOV eax, 0
    MOV ebx, 0
    MOV ecx, 0
    MOV edx, 0
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
    
 
    ;Display menu
    
    MOV eax, SYS_WRITE
    MOV ebx, STDOUT
    MOV ecx, msgA
    MOV edx, lenA
    INT 80h

    MOV eax, SYS_WRITE
    MOV ebx, STDOUT
    MOV ecx, msgS
    MOV edx, lenS
    INT 80h
    
    MOV eax, SYS_WRITE
    MOV ebx, STDOUT
    MOV ecx, msgD
    MOV edx, lenD
    INT 80h
    
    MOV eax, SYS_WRITE
    MOV ebx, STDOUT
    MOV ecx, msgM
    MOV edx, lenM
    INT 80h
    
    MOV eax, SYS_WRITE
    MOV ebx, STDOUT
    MOV ecx, msgMo
    MOV edx, lenMo
    INT 80h
	
	MOV eax, SYS_WRITE
    MOV ebx, STDOUT
    MOV ecx, msgI
    MOV edx, lenI
    INT 80h
    
    MOV eax, SYS_WRITE
    MOV ebx, STDOUT
    MOV ecx, msgDe
    MOV edx, lenDe
    INT 80h
    
    ;exit problem/solved
    MOV eax, SYS_WRITE
    MOV ebx, STDOUT
    MOV ecx, msgEx
    MOV edx, lenEx
    INT 80h
    
    
    ; Read menu option
    MOV eax, SYS_READ
    MOV ebx, STDIN
    MOV ecx, opt
    MOV edx, 8
    INT 80h
    
    ;Load the val selected
    ;XOR eax,eax ; clear eax
    MOV ah, [opt]
    SUB ah, '0' ;conv ascii
; stoped there
    CMP ah,1
    JE ADDition
    CMP ah,2
    JE SUBstraction
    CMP ah,3
    JE DIVision
    CMP ah,4
    JE multiply
    CMP ah,5
    JE modulo
    CMP ah,6
    JE increment
    CMP ah,7
    JE decrement  
    CMP eax,8
    JMP exit
    
    ;Write "The result is" !!!!
    MOV eax, SYS_WRITE
    MOV ebx, STDOUT
    MOV ecx, msg3
    MOV edx, len3
    INT 80h
    
newL:;thows message to choose option continue or exit

    MOV eax, 0
    MOV ebx, 0
    MOV ecx, 0
    MOV edx, 0
    ;throw message
    MOV eax, SYS_WRITE
    MOV ebx, STDOUT  
    MOV ecx, msgExO 
    MOV edx, lenExO
    INT 80h 
    
    
    ;read option2
    MOV eax, SYS_READ
    MOV ebx, STDIN
    MOV ecx, opt2
    MOV edx, 8
    INT 80h
    
    MOV ah, [opt2]
    SUB ah, '0'
    
    CMP ah,8
    JE  exit
    JNE loop1


ADDition:
    ;ASCII coverter
    MOV eax, [val1]
    SUB eax, '0'
    
    MOV ebx, [val2]
    SUB ebx, '0'
    
    ;Main opp
    ADD eax, ebx
    ADD eax, '0'
    MOV [res], eax
    
    MOV eax, SYS_WRITE
    MOV ebx, STDOUT  
    MOV ecx, msg3
    MOV edx, len3
    INT 80h
    
    ;PrINT
    MOV eax, SYS_WRITE        
    MOV ebx, STDOUT
    MOV ecx, res 
    MOV edx, 1
    INT 80h
    JMP newL
    

SUBstraction:
   ; ASCII converter
    MOV ah, [val1]
    SUB ah, '0'
    
    MOV bh, [val2]
    SUB bh, '0'
    
    ; Main operation (SUBtraction)
    SUB ah, bh

    ADD ah, '0'
    MOV [res], ah
    
    MOV eax, SYS_WRITE
    MOV ebx, STDOUT  
    MOV ecx, msg3
    MOV edx, len3
    INT 80h
    
    ; PrINT the result
    MOV eax, SYS_WRITE
    MOV ebx, STDOUT
    ;XOR ecx,ecx
    MOV ecx, res
    MOV edx, 1 
    INT 80h
    JMP newL
    
DIVision:
    ; Convert to integers
    MOV al, [val1]
    SUB al, '0'  
    MOV bl, [val2]
    SUB bl, '0'

    ; integer DIVision  
    MOV ah, 0 
    DIV bl
        
    ; Save result
    ADD al, '0'
    MOV [res], al

    ; PrINT result
    MOV eax, SYS_WRITE
    MOV ebx, STDOUT  
    MOV ecx, msg3
    MOV edx, len3
    INT 80h
    ; PrINT the result
    MOV eax, SYS_WRITE
    MOV ebx, STDOUT
    MOV ecx, res  
    MOV edx, 1
    INT 80h
    JMP newL

multiply:
    ; ASCII converter
    MOV eax, [val1]
    SUB eax, '0'
    
    MOV ebx, [val2]
    SUB ebx, '0'
    ; Main operation (MUL)
    IMUL ebx; single bite  instruction
    ADD eax, '0'
    MOV [res], eax
    
    MOV eax, SYS_WRITE
    MOV ebx, STDOUT  
    MOV ecx, msg3  
    MOV edx, len3
    INT 80h 
    
    ; PrINT the result
    MOV eax, SYS_WRITE
    MOV ebx, STDOUT
    MOV ecx, res
    MOV edx, 1 ; 
    INT 80h
    JMP newL

modulo:
    ; Ascii 
    MOV al, [val1]
    SUB al, '0'  

    MOV bl, [val2]
    SUB bl, '0'
    
    ; mod
    MOV ah, 0
    DIV bl  
    MOV al, ah

    ADD al, '0'
    MOV [res], al

    ; resIs
    MOV eax, SYS_WRITE
    MOV ebx, STDOUT  
    MOV ecx, msg3  
    MOV edx, len3
    INT 80h

	; PrINT the result
    MOV eax, SYS_WRITE
    MOV ebx, STDOUT
    MOV ecx, res   
    MOV edx, 1
    INT 80h
    JMP newL
    ; SYS_EXIT  

    
increment:
    ;testjump/works
    ;MOV eax, SYS_WRITE
    ;MOV ebx, STDOUT
    ;MOV ecx, opt
    ;MOV edx, 2 ; 
    ;INT 80h
    ; ASCII converter
    MOV eax, [val1]
    SUB eax, '0'
    
    MOV ebx, [val2]
    SUB ebx, '0'
    
    INC eax
    MOV[res],eax
    ADD eax, '0'
    MOV [res], eax
    
    INC ebx
    MOV[res2],ebx
    ADD ebx, '0'
    MOV [res2], ebx
    INT 80h
    
    MOV eax, SYS_WRITE
    MOV ebx, STDOUT
    MOV ecx, msg3
    MOV edx, len3
    INT 80h
    
    ;PrINT the result
    MOV eax, SYS_WRITE
    MOV ebx, STDOUT
    MOV ecx, res
    MOV edx, 2 ; 
    INT 80h
    
	; PrINT the result
    MOV eax, SYS_WRITE
    MOV ebx, STDOUT
    MOV ecx, res2
    MOV edx, 2 ; 
    INT 80h
    JMP newL
    
    
decrement:
    
    ; ASCII converter
    MOV eax, [val1]
    SUB eax, '0'
    
    MOV ebx, [val2]
    SUB ebx, '0'
    
    ; Main operation (DEC)
    
    DEC eax
    
    MOV[res],eax
    ADD eax, '0'
    MOV [res], eax
    
    DEC ebx
    MOV[res2],ebx
    ADD ebx, '0'
    MOV [res2], ebx
    MOV eax, SYS_WRITE
    MOV ebx, STDOUT
    MOV ecx, msg3
    MOV edx, len3
    INT 80h
    
    ; PrINT the result
    MOV eax, SYS_WRITE
    MOV ebx, STDOUT
    MOV ecx, res
    MOV edx, 2 ; 
    INT 80h
    ; PrINT the result
    MOV eax, SYS_WRITE
    MOV ebx, STDOUT
    MOV ecx, res2
    MOV edx, 2 ; 
    INT 80h
    JMP newL

exit:

   ; MOV edx,0
    ;MOV ebx,0
    ;MOV ecx,0
    ;MOV eax,0
   ; glavnoe
    MOV eax, SYS_WRITE
    MOV ebx, STDOUT
    MOV ecx, msg4
    MOV edx, len4
    INT 80h
    MOV	eax, SYS_EXIT
    XOR ebx,ebx
	INT 80h       ;call kernel


