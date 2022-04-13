extern malloc
extern free
extern fprintf

section .data


section .text

global strCmp
global strClone
global strDelete
global strPrint
global strLen

; ** String **
; int32_t strCmp(char* a, char* b)
; registros: a[rdi], b[rsi]

strCmp:
;prólogo
    push rbp
    mov rbp, rsp

    mov rcx, 0x0    ; posición en la string

compareNextChar:


    ; Me fijo si estoy en el final de a ó b
    cmp byte [rdi+rcx], 0x0
    je aEnd
    cmp byte [rsi,+rcx], 0x0
    je bEnd

    ; Comparo el caracter actual
    mov r8b, [rsi+rcx]
    cmp byte [rdi+rcx], r8b
    jl isLess
    jg isGreater

    ; Si son iguales, comparo el siguiente
    inc rcx
    jmp compareNextChar

aEnd:
    ; Me fijo si estoy al final de b
    cmp byte [rsi+rcx], 0x0
    ; Si estoy, son iguales
    je isEqual
    ; Sino, a es menor
    jmp isLess

bEnd:
    ; Me fijo si estoy al final de a
    cmp byte [rdi+rcx], 0x0
    ; Si estoy, son iguales
    je isEqual
    ; Sino, a es mayor
    jmp isGreater

isEqual:
    mov rax, 0x0
    jmp epilogue

isLess:
    mov rax, -1
    jmp epilogue

isGreater:
    mov rax, 0x1
    jmp epilogue

epilogue:
    pop rbp
    ret

; char* strClone(char* a)
strClone:
;prólogo
    push rbp
    mov rbp, rsp

    ; Me guardo el puntero al char
    push rdi
    sub rsp, 0x8
    
    ; Calculo el largo del string
    call strLen

    ; Reservo un malloc de esa cantidad de bytes
    mov rdi, rax
    call malloc

    ; Copio el char en esa posición
    pop rdi
    mov [rax], rdi

ret

; void strDelete(char* a)
strDelete:
ret

; void strPrint(char* a, FILE* pFile)
strPrint:
ret

; uint32_t strLen(char* a)
strLen:
;prólogo
    push rbp
    mov rbp, rsp
    
    mov rcx, -1

counterLoop:
    inc rcx
    cmp byte [rdi+rcx], 0x0
    jne counterLoop

    mov rax, rcx
    pop rbp
    ret

ret


