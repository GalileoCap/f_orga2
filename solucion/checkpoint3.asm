
;########### SECCION DE DATOS
section .data

;########### SECCION DE TEXTO (PROGRAMA)
section .text

;########### LISTA DE FUNCIONES EXPORTADAS
global complex_sum_z
global packed_complex_sum_z
global product_9_f

;########### DEFINICION DE FUNCIONES
;extern uint32_t complex_sum_z(complex_item *arr, uint32_t arr_length);
;registros: arr[rdi], arr_length[rsi]
complex_sum_z:
	;prologo
	push rbp
	mov rbp, rsp

	mov rcx, rsi	; Contador en arr_length
	mov rsi, 0x00	; Posición en el array
	mov r8, 0x00	; Inicializo la suma en cero


.cycle:			; etiqueta a donde retorna el ciclo que itera sobre arr

	mov rax, rsi
	mov r9, 0x20
	mul r9
	
	add r8, [rdi + rax + 0x18]
	inc rsi
	loop .cycle		; decrementa ecx y si es distinto de 0 salta a .cycle

	
	;epilogo

	movsx rax, r8d	; mueve el resultado que está en el rd8 con la extensión de signo al rax.

	pop rbp
	ret
	
;extern uint32_t packed_complex_sum_z(packed_complex_item *arr, uint32_t arr_length);
;registros: arr[rdi], arr_length[rsi]
packed_complex_sum_z:
	;prólogo
	push rbp
	mov rbp, rsp

	mov rcx, rsi	; Contador en arr_length
	mov rsi, 0x00	; Posición en el array
	mov r8, 0x00	; Inicializo la suma en cero

.cicle:
	mov rax, rsi
	mov r9, 0x18
	mul r9

	add r8, [rdi + rax + 0x14]
	inc rsi
	loop .cicle
	
	;epílogo
	movsx rax, r8d
	pop rbp
	ret


;extern void product_9_f(uint32_t * destination
;, uint32_t x1, float f1, uint32_t x2, float f2, uint32_t x3, float f3, uint32_t x4, float f4
;, uint32_t x5, float f5, uint32_t x6, float f6, uint32_t x7, float f7, uint32_t x8, float f8
;, uint32_t x9, float f9);
;registros y pila: destination[rdi], x1[rsi], f1[xmm0], x2[rdx], f2[xmm1], x3[rsx], f3[xmm2], x4[rbp + 0x10], f4[xmm3]
;	, x5[rbp + 0x18], f5[xmm4], x6[rbp + 0x20], f6[xmm5], x7[rbp + 0x28], f7[xmm6], x8[rbp + 0x30], f8[xmm7],
;	, x9[rbp + 0x38], f9[rbp + 0x40]
product_9_f:

	;prologo 
	push rbp
	mov rbp, rsp
	
	;convertimos los flotantes de cada registro xmm en doubles
	
	; COMPLETAR 
	
	;multiplicamos los doubles en xmm0 <- xmm0 * xmm1, xmmo * xmm2 , ...

	; COMPLETAR 

	; convertimos los enteros en doubles y los multiplicamos por xmm0. 

	; COMPLETAR 

	; epilogo 
	pop rbp
	ret

