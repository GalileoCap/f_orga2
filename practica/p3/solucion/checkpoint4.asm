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

.compareNextChar:
  ; Comparo el caracter actual
  mov r8b, [rdi]
  cmp r8b, [rsi]
  jl .isGreater ; TODO: Porque al reves anda
  jg .isLess

  ; Si son iguales me fijo si estoy en el final de alguno
  cmp byte [rdi], 0x0
  je .aEnd
  cmp byte [rsi], 0x0
  je .bEnd

  ; Si no termine, continuo
  inc rdi
	inc rsi
  jmp .compareNextChar

.aEnd
	cmp byte [rsi], 0x0
	je .isEqual
	jmp .isLess

.bEnd
	cmp byte [rdi], 0x0
	je .isEqual
	jmp .isGreater

.isEqual:
  mov rax, 0x0
  jmp .end

.isLess:
  mov rax, 0xffffffffffffffff
  jmp .end

.isGreater:
  mov rax, 0x1
  ;jmp .end

.end:
  pop rbp
  ret

; char* strClone(char* a)
strClone:
  push rbp
  mov rbp, rsp

	sub rsp, 0x8 ; A: Me guardo a
	push rdi

  call strLen ; A: rax = malloc(strLen(a) * 1)
  mov rdi, rax 
	inc rdi ; A: Agrego espacio para el nulo
	push rdi
	mov rax, malloc
  call rax 

	pop rcx ; A: Contador
  pop rdi ; A: Recupero al strng original
  mov rsi, rax ; U: La posición dentro del string copia
.loop:
  mov r8b, byte [rdi] ; A: Copio este char
  mov byte [rsi], r8b
  inc rsi ; A: Voy al siguiente char en ambos strings
  inc rdi 
	loop .loop

  ;NOTE: rax ya vale el puntero de la copia
  add rsp, 0x8 
  pop rbp
  ret

; void strDelete(char* a)
strDelete:
	push rbp
	mov rbp, rsp

	mov rax, free
	call rax

	pop rbp
	ret

; void strPrint(char* a, FILE* pFile)
strPrint:
	push rbp
	mov rbp, rsp

	mov rdx, rdi
	mov rdi, rsi
	mov rsi, rdx
	mov rdx, fprintf
	call rdx

	pop rbp
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

