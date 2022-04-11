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
strCmp:
  ;prólogo
  push rbp
  mov rbp, rsp

  mov rcx, 0x0    ; posición en la string
.compareNextChar:
  ; Me fijo si estoy en el final de a ó b
  cmp byte [rdi+rcx], 0x0
  je .aEnd
  cmp byte [rsi,+rcx], 0x0
  je .bEnd

  ; Comparo el caracter actual
  mov r8b, [rsi+rcx]
  cmp byte [rdi+rcx], r8b
  jl .isLess
  jg .isGreater

  ; Si son iguales, comparo el siguiente
  inc rcx
  jmp .compareNextChar

.aEnd:
  ; Me fijo si estoy al final de b
  cmp byte [rsi+rcx], 0x0
  ; Si estoy, son iguales
  je .isEqual
  ; Sino, a es menor
  jmp .isLess

.bEnd:
  ; Me fijo si estoy al final de a
  cmp byte [rdi+rcx], 0x0
  ; Si estoy, son iguales
  je .isEqual
  ; Sino, a es mayor
  jmp .isGreater

.isEqual:
  mov rax, 0x0
  jmp .epilogue

.isLess:
  mov rax, -1
  jmp .epilogue

.isGreater:
  mov rax, 0x1
  ;jmp .epilogue

.epilogue:
  pop rbp
  ret

; char* strClone(char* a)
strClone:
  push rbp
  mov rbp, rsp

  call strLen ; A: rdi ya tiene el valor correcto
  sub rsp, 0x8 ; A: Padding
  push rdi ; A: Me guardo a

  mov rdi, rax
  ;call malloc ; A: Me reservo el espacio necesario TODO: No anda

  pop rdi ; A: Recupero al strng original
  ;mov rsi, rax ; U: La posición dentro del string copia
  mov rsi, rdi ; TODO: Lo voy a tapar consigomismo, es solo por el malloc
.loop:
  mov byte rdx, [rsi] ; A: Copio este char
  mov [rsi], rdx
  inc rsi ; A: Voy al siguiente char en ambos strings
  inc rdi 
  cmp byte [rdi], 0x0 ; A: Si llegué al final del string, termino
  je .end
  jmp .loop

.end:
  ;NOTE: rax ya vale el puntero de la copia
  add rsp, 0x8 
  pop rbp
  ret

; void strDelete(char* a)
strDelete:
ret

; void strPrint(char* a, FILE* pFile)
strPrint:
ret

; uint32_t strLen(char* a)
strLen:
  push rbp
  mov rbp, rsp

  mov rcx, -1

.loop:
    inc rcx
    cmp byte [rdi+rcx], 0x0
    jne .loop

  mov rax, rcx
  pop rbp
  ret

  ret



