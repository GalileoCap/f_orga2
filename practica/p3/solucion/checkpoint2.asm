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
; registros: x1[edi], x2[esi], x3[edx], x4[ecx]
alternate_sum_4:
  ; A: Prólogo
  push rbp
  mov rbp, rsp

  mov eax, edi ; res = x1
  sub eax, esi ; res -= x2
  add eax, edx ; res += x3
  sub eax, ecx ; res -= x4

  pop rbp
  ret

; uint32_t alternate_sum_4_using_c(uint32_t x1, uint32_t x2, uint32_t x3, uint32_t x4);
; registros: x1[edi], x2[esi], x3[edx], x4[ecx]
alternate_sum_4_using_c: 
  ; A: Prologo
  push rbp
  mov rbp, rsp 

  sub rsp, 0x10 ; A: Me reservo 16-Bytes en la memoria
  mov [rbp - 0x8], edx ; A: Me guardo x4 y x3
  mov [rbp - 0x10], ecx
  
  ;A: eax = restar_c(x1, x2)
  ;NOTA: x1 y x2 ya estan en edi y esi
  call restar_c

  ;A: eax = sumar_c(eax, x3) = sumar_c(restar_c(x1, x2), x3)
  mov edi, eax ; A: Guardo el resultado del call anterior en el primer parámetro
  mov esi, [rbp - 0x8] ; A: Traigo x3
  call sumar_c

  ;A: eax = sumar_c(eax, x4) = restar_c(sumar_c(restar_c(x1, x2), x3), x4)
  mov edi, eax
  mov esi, [rbp - 0x10]
  call restar_c

  ; A: Epilogo
  ; NOTE: Ya está en rax el resultado
  add rsp, 0x10 ; A: Libero el espacio en el stack
  pop rbp 
  ret 

; uint32_t alternate_sum_4_simplified(uint32_t x1, uint32_t x2, uint32_t x3, uint32_t x4);
; registros: x1[edi], x2[esi], x3[edx], x4[ecx]
alternate_sum_4_simplified:
  mov eax, edi
  sub eax, esi
  add eax, edx
  sub eax, ecx

	ret

; uint32_t alternate_sum_8(uint32_t x1, uint32_t x2, uint32_t x3, uint32_t x4, uint32_t x5, uint32_t x6, uint32_t x7, uint32_t x8);	
; registros y pila: x1[edi], x2[esi], x3[edx], x4[ecx], x5[r8d], x6[r9d], x7[rbp + 0x10], x8[rbp + 0x18]
alternate_sum_8:
  ; A: Prólogo
  push rbp
  mov rbp, rsp

  sub rsp, 0x20 ; A: Me reservo 32-Bytes en el stack
  mov [rbp - 0x8], r8d ; A: Guardo los parámetros ; NOTE: Hago esto porque no tengo certeza de que el call no me los cambie
  mov [rbp - 0x10], r9d
  mov r8d, [rbp + 0x10] ; NOTE: No existe mov de memoria a memoria
  mov [rbp - 0x18], r8d
  mov r8d, [rbp + 0x18]
  mov [rbp - 0x20], r8d

  ; NOTE: Los registros ya estan en su lugar correcto
  call alternate_sum_4 ; A: eax = alternate_sum(x1, x2, x3, x4)

  mov edi, [rbp - 0x8] ; A: Recupero los parametros que guarde
  mov esi, [rbp - 0x10]
  mov edx, [rbp - 0x18]
  mov ecx, [rbp - 0x20]
  mov [rbp - 0x8], eax ; A: Me guardo el resultado anterior
  call alternate_sum_4 ; A: eax = alternate_sum(x5, x6, x7, x8)

  add eax, [rbp - 0x8] ; A: Sumo ambos resultados
  add rsp, 0x20 ; A: Libero el espacio en el stack
  pop rbp
	ret

; SUGERENCIA: investigar uso de instrucciones para convertir enteros a floats y viceversa
;void product_2_f(uint32_t * destination, uint32_t x1, float f1);
;registros: destination[rdi], x1[esi], f1[xmm0] 
product_2_f:
  push rbp
  mov rbp, rsp

  cvtsi2ss xmm1, esi ; A: Convierte x1 en float y lo guarda en xmm1
  mulss xmm0, xmm1 ; A: Los multiplico, y guarda en xmm0
  cvttss2si esi, xmm0 ; A: Convierto al valor a int truncando
  mov [rdi], esi ; A: Lo guardo en el destino

  pop rbp
  ret
