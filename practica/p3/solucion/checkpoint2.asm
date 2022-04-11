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
;; uint32_t alternate_sum_4(uint32_t x1, uint32_t x2, uint32_t x3, uint32_t x4);
;; registros: x1[RDI], x2[RSI], x3[RDX], x4[RCX]
;alternate_sum_4:
	;;prologo
	;;recordar que si la pila estaba alineada a 16 al hacer la llamada
	;;con el push de RIP como efecto del CALL queda alineada a 8
  ;push rbp
  ;mov rbp, rsp
  ;sub rsp, 0x4 ; A: Me reservo 4-bytes en la memoria

  ;mov [rbp], rdi ; res = x1
  ;sub [rbp], rsi ; res -= x2
  ;add [rbp], rdx ; res += x3
  ;sub [rbp], rcx ; res -= x4
  
  ;;epilogo
  ;mov rax, [rbp] ; A: Guardo el valor de retorno en el registro
  ;add rsp, 0x10 ; A: Recupero el rsp original
  ;pop rbp ; A: Recupero el rbp original

  ;ret

; uint32_t alternate_sum_4(uint32_t x1, uint32_t x2, uint32_t x3, uint32_t x4);
; registros: x1[RDI], x2[RSI], x3[RDX], x4[RCX]
alternate_sum_4:
  mov rax, rdi ; res = x1
  sub rax, rsi ; res -= x2
  add rax, rdx ; res += x3
  sub rax, rcx ; res -= x4

  ret

; uint32_t alternate_sum_4_using_c(uint32_t x1, uint32_t x2, uint32_t x3, uint32_t x4);
; registros: x1[rdi], x2[rsi], x3[rdx], x4[rcx]
;alternate_sum_4_using_c: 
  ;;prologo
  ;push rbp ; alineado a 16
  ;mov rbp, rsp
  ;sub rsp, 0x10 ; A: Me reservo 8-bytes en la memoria para x3 y x4, y 8-bytes de padding
  ;mov [rbp], rdx ; A: Guardo x3
  ;mov [rbp - 0x4], rcx ; A: Guardo x4
  
  ;;A: Llamo a restar_c(x1, x2)
  ;;NOTA: x1 y x2 ya estan en rdi y rsi
  ;call restar_c

  ;;A: Llamo a sumar_c(restar_c(x1, x2), x3)
  ;mov rdi, rax ; A: Guardo el resultado del call anterior en el primer parámetro
  ;mov rsi, [rbp]
  ;call sumar_c

  ;;A: Llamo a restar_c(sumar_c(restar_c(x1, x2), x3), x4)
  ;mov rdi, rax
  ;mov rsi, [rbp - 0x4]
  ;call restar_c

  ;;epilogo
  ;;NOTA: Ya está en rax el resultado
  ;add rsp, 0x10
  ;pop rbp
  ;ret 

; uint32_t alternate_sum_4_using_c(uint32_t x1, uint32_t x2, uint32_t x3, uint32_t x4);
; registros: x1[rdi], x2[rsi], x3[rdx], x4[rcx]
alternate_sum_4_using_c: 
  ;prologo
  push rbp ;A:  alineado a 16
  mov rbp, rsp ; A: Muevo la base
  push rcx ; A: Me guardo x4 y x3, sigue alineado a 16
  push rdx
  
  ;A: Llamo a restar_c(x1, x2)
  ;NOTA: x1 y x2 ya estan en rdi y rsi
  call restar_c

  ;A: Llamo a sumar_c(restar_c(x1, x2), x3)
  mov rdi, rax ; A: Guardo el resultado del call anterior en el primer parámetro
  pop rsi ; A: Traigo x3, queda alineado a 8
  sub rsp, 0x8 ; A: Alineo a 16 de nuevo con padding
  call sumar_c

  ;A: Llamo a restar_c(sumar_c(restar_c(x1, x2), x3), x4)
  mov rdi, rax
  add rsp, 0x8 ; A: Saco el padding
  pop rsi ; A: Traigo x4, queda alineado a 16
  call restar_c

  ;epilogo
  ;NOTA: Ya está en rax el resultado
  pop rbp ; A: Recupero el rbp original
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
; registros y pila: x1[rdi], x2[rsi], x3[rdx], x4[rcx], x5[r8], x6[r9], x7[rbp + 0x18], x8[rbp + 0x10]
;alternate_sum_8:
	;;prologo

  ;push rbp
  ;mov rbp, rsp
  ;sub rsp, 0x4

  ;call alternate_sum_4

  ;mov [rbp], rax

  ;mov rdi, r8 ; r8es += x5
  ;mov rsi, r9 ; res -= x6
  ;mov rdx, [rbp + 0x14] ; res += x7
  ;mov rcx, [rbp + 0x10] ; res -= x8

  ;call alternate_sum_4

	;;epilogo
  ;add rax, [rbp]
  ;add rsp, 0x4
  ;pop rbp
	;ret

; uint32_t alternate_sum_8(uint32_t x1, uint32_t x2, uint32_t x3, uint32_t x4, uint32_t x5, uint32_t x6, uint32_t x7, uint32_t x8);	
; registros y pila: x1[rdi], x2[rsi], x3[rdx], x4[rcx], x5[r8], x6[r9], x7[rbp + 0x18], x8[rbp + 0x10]
alternate_sum_8:
  push rbp ; A: Alineado a 16
  mov rbp, rsp

  push r8 ; A: Me guardo los parametros en orden, manteniendo alineamiento
  push r9
  mov r12, [rbp + 0x10]
  push r12
  mov r12, [rbp + 0x18]
  push r12

  call alternate_sum_4 ; A: Los registros ya estan en su lugar correcto

  pop rcx ; A: Recupero los parametros que guarde, en orden
  pop rdx
  pop rsi
  pop rdi
  push rax ; A: Me guardo el resultado
  sub rsp, 0x8 ; A: Alineo con padding
  call alternate_sum_4

  add rsp, 0x8 ; A: Saco el padding
  pop r12 ; A: Recupero el resultado anterior
  add rax, r12 ; A: Sumo ambos resultados

  pop rbp
	ret
	

; SUGERENCIA: investigar uso de instrucciones para convertir enteros a floats y viceversa
;void product_2_f(uint32_t * destination, uint32_t x1, float f1);
;registros: destination[rdi], x1[rsi], f1[xmm0] ;TODO: xmm0 se repite para return y param?
product_2_f:
  cvtsi2ss xmm1, rsi ; A: Convierte x1 en float y lo guarda en xmm1
  mulss xmm0, xmm1 ; A: Los multiplico, y guarda en xmm0

  cvttss2si rsi, xmm0 ; A: Convierto al valor a int truncando
  mov [rdi], rsi ; A: Lo guardo en el destino

  ret

;void product_2_f(uint32_t * destination, uint32_t x1, float f1);
;registros: destination[rdi], x1[rsi], f1[xmm0] ;TODO: xmm0 se repite para return y param?
;product_2_f:
  ;movq xmm2, rsi
  ;cvtdq2ps xmm2, xmm2
  ;mulps xmm0, xmm2
  ;cvtps2dq xmm1, xmm0
  ;movq [rdi], xmm1

  ;ret

