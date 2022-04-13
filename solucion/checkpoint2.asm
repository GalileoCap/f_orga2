extern sumar_c
extern restar_c
;########### SECCION DE DATOS
section .data

;########### SECCION DE TEXTO (PROGRAMA)
section .text

;########### LISTA DE FUNCIONES EXPORTADAS

global alternate_sum_4
global alternate_sum_4_simplified
global alternate_sum_8
global product_2_f
global alternate_sum_4_using_c

;########### DEFINICION DE FUNCIONES
; uint32_t alternate_sum_4(uint32_t x1, uint32_t x2, uint32_t x3, uint32_t x4);
; registros: x1[RDI], x2[RSI], x3[RDX], x4[RCX]
alternate_sum_4:
	;prologo
	push rbp
	mov rbp, rsp

	mov rax, rdi
	sub rax, rsi
	add rax, rdx
	sub rax, rcx

	;recordar que si la pila estaba alineada a 16 al hacer la llamada
	;con el push de RIP como efecto del CALL queda alineada a 8

	;epilogo
	pop rbp

	ret

; uint32_t alternate_sum_4_using_c(uint32_t x1, uint32_t x2, uint32_t x3, uint32_t x4);
; registros: x1[rdi], x2[rsi], x3[rdx], x4[rcx]
alternate_sum_4_using_c: 

	;prologo
    push rbp ; alineado a 16
    mov rbp,rsp

	push rcx
	push rdx

	;x1 - x2
	call restar_c

	;res + x3
	mov rdi, rax
	pop rsi
	sub rsp, 0x8
	call sumar_c

	;res - x4
	mov rdi, rax
	add rsp, 0x8
	pop rsi
	call restar_c

	;epilogo
	pop rbp
    ret 



; uint32_t alternate_sum_4_simplified(uint32_t x1, uint32_t x2, uint32_t x3, uint32_t x4);
; registros: x1[rdi], x2[rsi], x3[rdx], x4[rcx]

alternate_sum_4_simplified:
	mov rax, rdi
	sub rax, rsi
	add rax, rdx
	sub rax, rcx
	ret


; uint32_t alternate_sum_8(uint32_t x1, uint32_t x2, uint32_t x3, uint32_t x4, uint32_t x5, uint32_t x6, uint32_t x7, uint32_t x8);	
; registros y pila: x1[rdi], x2[rsi], x3[rdx], x4[rcx], x5[r8], x6[r9], x7[rbp+0x10], x8[rbp+0x20]
alternate_sum_8:
	;prologo
	push rbp
	mov rbp, rsp

	push r8
	push r9

	mov r12, [rbp+0x10]
	mov r13, [rbp+0x18]

	push r12
	push r13

	call alternate_sum_4_simplified

	pop rcx
	pop rdx
	pop rsi
	pop rdi
	push rax
	sub rsp, 0x8

	call alternate_sum_4_simplified

	add rsp, 0x8
	push rax

	pop rsi
	pop rdi

	call sumar_c

	;recordar que si la pila estaba alineada a 16 al hacer la llamada
	;con el push de RIP como efecto del CALL queda alineada a 8

	;epilogo
	mov rsp, rbp
	pop rbp

	ret
	

; SUGERENCIA: investigar uso de instrucciones para convertir enteros a floats y viceversa
;void product_2_f(uint32_t * destination, uint32_t x1, float f1);
;registros: destination[?], x1[?], f1[?]

; Cómo hago pop de un float del stack?
; Qué significa single precision?
product_2_f:
	movq xmm2, rsi
	cvtdq2ps xmm2, xmm2
	mulps xmm0, xmm2
	cvtps2dq xmm1, xmm0
	movq [rdi], xmm1

	ret

