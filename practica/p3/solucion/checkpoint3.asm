
;########### SECCION DE DATOS
section .data
complex_item_size: equ 0x20 ; NOTE: Uso equ en lugar de dd por problemas de compilación ; NOTE: Ver checkpoints.h para ver cómo lo calculé
complex_item_z_pos: equ 0x18
packed_complex_item_size: equ 0x18 
packed_complex_item_z_pos: equ 0x14

;########### SECCION DE TEXTO (PROGRAMA)
section .text

;########### LISTA DE FUNCIONES EXPORTADAS
global complex_sum_z
global packed_complex_sum_z
global product_9_f

;########### DEFINICION DE FUNCIONES
;extern uint32_t complex_sum_z(complex_item *arr, uint32_t arr_length);
;registros: arr[rdi], arr_length[esi]
complex_sum_z:
  ; A: Prólogo
  push rbp 
  mov rbp, rsp

  mov eax, 0x0 ; A: res = 0 
  cmp esi, 0x0 ; A: Si la lista esta vacia, ya terminé
  jz .end

  add rdi, complex_item_z_pos ; A: Arranco con el offset para z
  mov ecx, esi ; A: Empiezo el contador en el tamaño
.cycle:
  add eax, [rdi] ; A: res += arr[i].z
  add rdi, complex_item_size ; A: Avanzo un elemento
	loop .cycle	; A: decrementa ecx y si es distinto de 0 salta a .cycle

.end:
  ; NOTE: El resultado ya está en rax porque fui operando sobre eax que son los bits menos significativos de rax
  pop rbp
	ret
	
;extern uint32_t packed_complex_sum_z(packed_complex_item *arr, uint32_t arr_length);
;registros: arr[rdi], arr_length[esi]
packed_complex_sum_z:
  ; A: Prólogo
  push rbp 
  mov rbp, rsp

  mov eax, 0x0 ; A: res = 0 
  cmp esi, 0x0 ; A: Si la lista esta vacia, ya termine
  jz .end

 	add rdi, packed_complex_item_z_pos ; A: Arranco con el offset z 
  mov ecx, esi ; A: Empiezo el contador en el tamaño
.cycle:
  add eax, [rdi] ; A: res += arr[i].z
  add rdi, packed_complex_item_size ; A: Avanzo un elemento
	loop .cycle	; A: decrementa ecx y si es distinto de 0 salta a .cycle

.end:
  ; NOTE: El resultado ya está en rax porque fui operando sobre eax que son los bits menos significativos de rax
  pop rbp
	ret

;extern void product_9_f(double * destination
;, uint32_t x1, float f1, uint32_t x2, float f2, uint32_t x3, float f3, uint32_t x4, float f4
;, uint32_t x5, float f5, uint32_t x6, float f6, uint32_t x7, float f7, uint32_t x8, float f8
;, uint32_t x9, float f9);
;registros y pila: destination[rdi], x1[esi], f1[xmm0], x2[edx], f2[xmm1], x3[ecx], f3[xmm2], x4[r8d], f4[xmm3]
;	, x5[r9d], f5[xmm4], x6[rbp + 0x10], f6[xmm5], x7[rbp + 0x18], f7[xmm6], x8[rbp + 0x20], f8[xmm9],
;	, x9[rbp + 0x28], f9[rbp + 0x30]
product_9_f:
  ; A: Prólogo
  push rbp
  mov rbp, rsp

  sub rsp, 0x10 ; A: Me reservo 16-Bytes en el stack
	
  cvtss2sd xmm0, xmm0 ; A: Convierto a xmm0 a double
  movq rax, xmm0 ; A: Lo guardo, porqe voy a necesitar el registro para convertir a f9
  cvtss2sd xmm0, [rbp + 0x30] ; A: Convierto a f9
  movq [rbp + 0x30], xmm0 ; A: Lo devuelvo a f9
  cvtss2sd xmm1, xmm1 ; A: Convierto al resto
  cvtss2sd xmm2, xmm2 
  cvtss2sd xmm3, xmm3 
  cvtss2sd xmm4, xmm4 
  cvtss2sd xmm5, xmm5 
  cvtss2sd xmm6, xmm6 
  cvtss2sd xmm7, xmm7 
  movq xmm0, rax ; A: Recupero a xmm0

  mulsd xmm0, xmm1 ; A: Los multiplico guardando el resultado en xmm0
  mulsd xmm0, xmm2
  mulsd xmm0, xmm3
  mulsd xmm0, xmm4
  mulsd xmm0, xmm5
  mulsd xmm0, xmm6
  mulsd xmm0, xmm7
  mulsd xmm0, [rbp + 0x30]

  cvtsi2sd xmm1, esi ; A: Convierto los enteros a double guardándolos en xmm1, y los multiplico por xmm0, guardándo el resultado en xmm0
  mulsd xmm0, xmm1
  cvtsi2sd xmm1, edx 
  mulsd xmm0, xmm1
  cvtsi2sd xmm1, ecx 
  mulsd xmm0, xmm1
  cvtsi2sd xmm1, r8d
  mulsd xmm0, xmm1
  cvtsi2sd xmm1, r9d
  mulsd xmm0, xmm1
  cvtsi2sd xmm1, [rbp + 0x10] 
  mulsd xmm0, xmm1
  cvtsi2sd xmm1, [rbp + 0x18] 
  mulsd xmm0, xmm1
  cvtsi2sd xmm1, [rbp + 0x20] 
  mulsd xmm0, xmm1
  cvtsi2sd xmm1, [rbp + 0x28] 
  mulsd xmm0, xmm1

  movq [rdi], xmm0 ; A: Guardo el resultado en el destino

  add rsp, 0x10 ; A: Libero el espacio en el stack
  pop rbp
	ret

