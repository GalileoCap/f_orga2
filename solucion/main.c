#include <stdio.h>
#include <stdlib.h>
#include <ctype.h>
#include <string.h>
#include <assert.h>

#include "checkpoints.h"

int main (void){
	/* Acá pueden realizar sus propias pruebas */

	/* alternate_sum_4 */
	assert(alternate_sum_4(8,2,5,1) == 10);
	assert(alternate_sum_4(8,2,5,2) == 9);

	/* alternate_sum_4_using_c */
	assert(alternate_sum_4_using_c(8,2,5,1) == 10);
	assert(alternate_sum_4_using_c(8,2,5,2) == 9);

	/* alternate_sum_4_simplified */
	assert(alternate_sum_4_simplified(8,2,5,1) == 10);
	assert(alternate_sum_4_simplified(8,2,5,2) == 9);

	/* alternate_sum_8 */
	assert(alternate_sum_8(8,2,5,1,8,2,5,1) == 20);
	assert(alternate_sum_8(8,2,5,2,8,2,5,2) == 18);	

	/* product_2_f */
	uint32_t n;
	product_2_f(&n, 2, 3.5);
	assert(n == 7);

	/* complex_sum_z */
	complex_item item1;
	item1.w = 1;
	item1.x = 2;
	item1.y = 3;
	item1.z = 4;

	complex_item item2;
	item2.w = 4;
	item2.x = 5;
	item2.y = 6;
	item2.z = 7;

	complex_item item3;
	item3.w = 8;
	item3.x = 9;
	item3.y = 10;
	item3.z = 11;

	complex_item arr[3] = {item1, item2, item3};
	assert(complex_sum_z(arr, 3) == 22);

	/* packed_complex_sum_z */
	packed_complex_item item1p;
	item1p.w = 1;
	item1p.x = 2;
	item1p.y = 3;
	item1p.z = 4;

	packed_complex_item item2p;
	item2p.w = 5;
	item2p.x = 6;
	item2p.y = 7;
	item2p.z = 8;

	packed_complex_item item3p;
	item3p.w = 9;
	item3p.x = 10;
	item3p.y = 11;
	item3p.z = 12;

	packed_complex_item arrp[3] = {item1p, item2p, item3p};

	assert(packed_complex_sum_z(arrp, 3) == 24);

	/* strCmp */
	char a[] = "abcde";
	char b[] = "abcdf";
	char c[] = "abcdef";
	char d[] = "";
	assert(strCmp(a, b) == -1);
	assert(strCmp(b, a) == 1);
	assert(strCmp(a, a) == 0);
	assert(strCmp(a, c) == -1);
	assert(strCmp(c, a) == 1);

	/* strLen */
	assert(strLen(a) == 5);
	assert(strLen(c) == 6);
	assert(strLen(d) == 0);

	/* strClone */
	char e = 'a';
	strClone(&e);

	return 0;    
}