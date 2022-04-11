
;########### SECCION DE DATOS
section .data

;########### SECCION DE TEXTO (PROGRAMA)
section .text

;########### LISTA DE FUNCIONES EXPORTADAS
global complex_sum_z
global packed_complex_sum_z
global product_9_f

;########### DEFINICION DE FUNCIONES
;extern uint32_t complex_sum_z_h(*arr, uint32_t arr_length, uint element_size, uint z_pos)
complex_sum_z_h:
  push rbp
  mov rbp, rsp

  mov r12, rdi ; U: Posición en el array
  add r12, rcx ; A: Arranco con el offset z 
  mov rcx, rsi ; A: Empiezo el contador en el tamaño
  mov r13, 0x0 ; A: res = 0 

  cmp rcx, 0x0 ; A: Si la lista esta vacia, ya termine
  jz .end
.cycle:
  add r13, [r12] ; A: res += arr[i].z
  add r12, rdx ; A: Avanzo un elemento
	loop .cycle		; decrementa ecx y si es distinto de 0 salta a .cycle

.end:
  mov rax, r13
  pop rbp
  ret

;extern uint32_t complex_sum_z(complex_item *arr, uint32_t arr_length);
;registros: arr[rdi], arr_length[rsi]
complex_sum_z:
  push rbp ; A: Alineamiento
  mov rbp, rsp

  mov rdx, 0x20 ; A: Tamaño de cada elemento
  mov rcx, 0x18 ; A: Posicion de z dentro del elemento
  call complex_sum_z_h

  pop rbp
	ret
	
;extern uint32_t packed_complex_sum_z(packed_complex_item *arr, uint32_t arr_length);
;registros: arr[?], arr_length[?]
packed_complex_sum_z:
  push rbp ; A: Alineamiento
  mov rbp, rsp

  mov rdx, 0x18
  mov rcx, 0x14
  call complex_sum_z_h

  pop rbp
	ret

;extern void product_9_f(double * destination
;, uint32_t x1, float f1, uint32_t x2, float f2, uint32_t x3, float f3, uint32_t x4, float f4
;, uint32_t x5, float f5, uint32_t x6, float f6, uint32_t x7, float f7, uint32_t x8, float f8
;, uint32_t x9, float f9);
;registros y pila: destination[rdi], x1[rsi], f1[xmm0], x2[rdx], f2[xmm1], x3[rcx], f3[xmm2], x4[r8], f4[xmm3]
;	, x5[r9], f5[xmm4], x6[rbp + 0x20], f6[xmm5], x7[rbp + 0x1C], f7[xmm6], x8[rbp + 0x18], f8[xmm9],
;	, x9[rbp + 0x14], f9[rbp + 0x10]
product_9_f:
  push rbp
  mov rbp, rsp
  sub rsp, 0x10
	
  cvtss2sd xmm0, xmm0 ; A: Convierto a xmm0 a double
  movq r12, xmm0 ; A: Lo guardo, porqe voy a necesitar el registro para convertir a f9
  cvtss2sd xmm0, [rbp + 0x10] ; A: Convierto a f9
  movq [rbp + 0x10], xmm0
  cvtss2sd xmm1, xmm1 ; A: Convierto al resto
  cvtss2sd xmm2, xmm2 
  cvtss2sd xmm3, xmm3 
  cvtss2sd xmm4, xmm4 
  cvtss2sd xmm5, xmm5 
  cvtss2sd xmm6, xmm6 
  cvtss2sd xmm7, xmm7 
  movq xmm0, r12 ; A: Recupero a xmm0

  mulsd xmm0, xmm1
  mulsd xmm0, xmm2
  mulsd xmm0, xmm3
  mulsd xmm0, xmm4
  mulsd xmm0, xmm5
  mulsd xmm0, xmm6
  mulsd xmm0, xmm7
  mulsd xmm0, [rbp + 0x10]

  cvtsi2sd xmm1, rsi 
  mulsd xmm0, xmm1
  cvtsi2sd xmm1, rdx 
  mulsd xmm0, xmm1
  cvtsi2sd xmm1, rcx 
  mulsd xmm0, xmm1
  cvtsi2sd xmm1, r8 
  mulsd xmm0, xmm1
  cvtsi2sd xmm1, r9 
  mulsd xmm0, xmm1
  cvtsi2sd xmm1, [rbp + 0x20] 
  mulsd xmm0, xmm1
  cvtsi2sd xmm1, [rbp + 0x1C] 
  mulsd xmm0, xmm1
  cvtsi2sd xmm1, [rbp + 0x18] 
  mulsd xmm0, xmm1
  cvtsi2sd xmm1, [rbp + 0x14] 
  mulsd xmm0, xmm1

  movq [rdi], xmm0 ; A: Lo guardo en el destino

  add rsp, 0x10
  pop rbp
	ret

