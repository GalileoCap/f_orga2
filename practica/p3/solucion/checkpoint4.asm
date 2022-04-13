extern malloc
extern free
extern fprintf

section .data
strnull: db "NULL", 0x0

section .text

global strCmp
global strClone
global strDelete
global strPrint
global strLen

; ** String **

; int32_t strCmp(char* a, char* b)
strCmp:
  ; A: Prólogo
  push rbp
  mov rbp, rsp

.loop:
  ; A: Comparo ambos caracteres 
  mov r8b, byte [rdi] ; NOTA: Aclarar byte es redundante porque estoy moviendo a r8b, pero por claridad lo hago
  cmp r8b, byte [rsi]
  jl .isGreater ; NOTE: Están "al revés" porque los tests de la cátedra consideran 'a' > 'b' > 'c' ... > 'z', al revés que en ASCII
  jg .isLess

  ; A: Si son iguales me fijo si estoy en el final de alguno
  cmp byte [rdi], 0x0 
  je .aEnd
  cmp byte [rsi], 0x0
  je .bEnd

  ; A: Si no termine, continuo
  inc rdi
	inc rsi
  jmp .loop

.aEnd:
  ; A: Si b también terminó, son iguales, sino a < b
	cmp byte [rsi], 0x0
	je .isEqual
	jmp .isLess

.bEnd:
  ; A: Si a también terminó, son iguales, sino a > b
	cmp byte [rdi], 0x0
	je .isEqual
	jmp .isGreater
  ; NOTE: Podría ahorrarme una operación haciendo
  ;   jne .isGreater
  ; pero por claridad lo dejo similar a .aEnd

.isEqual:
  ; A: Devuelvo 0
  mov eax, 0x0
  jmp .end

.isLess:
  ; A: Devuelvo -1
  mov eax, 0xffffffff
  jmp .end

.isGreater:
  ; Devuelvo 1
  mov eax, 0x1
  jmp .end ; NOTE: Podría ahorrarme esta operación, pero por claridad la dejo

.end:
  ; NOTE: Ya está en rax el resultado, porque lo fui guardando en eax, que es la parte baja de rax
  pop rbp ; A: Epílogo
  ret

; char* strClone(char* a)
strClone:
  ; A: Prólogo
  push rbp 
  mov rbp, rsp

  sub rsp, 0x10 ; A: Me reservo 16-Bytes en el stack
	mov [rbp - 0x8], rdi ; A: Me guardo a a

  ; A: Este bloque: rax = malloc((strLen(a) + 1) * 1)
  call strLen ; A: rax = strLen(a)
  mov rdi, rax ; A: rdi = rax
	inc rdi ; A: rdi++ // Agrego espacio para el nulo
	mov [rbp - 0x10], rdi ; A: Me guardo el tamaño del string+1
	mov rax, malloc ; A: rax = malloc(rdi)
  call rax 

	mov rcx, [rbp - 0x10] ; A: rcx = strLen(a) + 1 // Recupero variables
  mov rdi, [rbp - 0x8] ; A: rdi = a
  mov rsi, rax ; A: rsi = malloc(...) ; U: La posición dentro del string copia
.loop:
  mov r8b, byte [rdi] ; A: Copio este char al string nuevo
  mov byte [rsi], r8b
  inc rsi ; A: Voy al siguiente char en ambos strings
  inc rdi 
	loop .loop ; A: Si no terminé, loopeo

  ; NOTE: rax ya vale el puntero de la copia

  add rsp, 0x10 ; A: Libero espacio en el stack
  pop rbp ; A: Epílogo
  ret

; void strDelete(char* a)
strDelete:
  ; A: Prólogo
	push rbp
	mov rbp, rsp

	mov rax, free ; A: Llamo a free con el mismo puntero
	call rax

	pop rbp ; A: Epílogo
	ret

; void strPrint(char* a, FILE* pFile)
strPrint:
  ; A: Prólogo
	push rbp
	mov rbp, rsp

	mov rdx, rdi ; A: rdx = a

  cmp byte [rdi], 0x0 ; A: Si es el string vacío
  je .null
  jmp .call

.null:
  mov rdx, strnull ; A: rdx -> strnull = "NULL"

.call:
	mov rdi, rsi ; A: rdi = pFile
  mov rsi, rdx ; A: rsi = rdx ó = a
	mov rdx, fprintf ; A: Llamo a fprintf NOTA: Por como está compilado hay que hacer este "hack"
  call rdx

	pop rbp ; A: Epílogo
	ret

; uint32_t strLen(char* a)
strLen:
  ; A: Prólogo
  push rbp 
  mov rbp, rsp

  mov eax, 0xffffffff ; A: res = -1

.loop:
    inc eax ; A: res += 1
    inc rdi ; A: Me muevo al siguiente caracter
    cmp byte [rdi - 0x1], 0x0 ; A: Si no llegué al final del string, sigo
    jne .loop

  ; NOTE: Ya está en rax el resultado, porque lo fui guardando en eax, que es la parte baja de rax
  pop rbp ; A: Epílogo
  ret

