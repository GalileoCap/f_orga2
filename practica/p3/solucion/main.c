#include <stdio.h>
#include <stdlib.h>
#include <ctype.h>
#include <string.h>
#include <assert.h>

#include "checkpoints.h"

int main (void){
  uint32_t res;

  printf("alternate_sum_4\n");
  res = alternate_sum_4(8, 2, 5, 1);
  printf("%i", res);
  assert(res == 10);
  res = alternate_sum_4(8, 2, 5, 2);
  printf(" %i\n", res);
  assert(res == 9);

  printf("alternate_sum_4_using_c\n");
  res = alternate_sum_4_using_c(8,2,5,1);
  printf("%i", res);
  assert(res == 10);	
  res = alternate_sum_4_using_c(8,2,5,2);
  printf(" %i\n", res);
  assert(res == 9);	

  printf("alternate_sum_4_simplified\n");
  res = alternate_sum_4_simplified(8,2,5,1);
  printf("%i", res);
  assert(res == 10);	
  res = alternate_sum_4_simplified(8,2,5,2);
  printf(" %i\n", res);
  assert(res == 9);	

  printf("alternate_sum_8\n");
  res = alternate_sum_8(8,2,5,1,8,2,5,1);
  printf("%i", res);
  assert(res == 20);
  res = alternate_sum_8(8,2,5,2,8,2,5,2);
  printf(" %i\n", res);
  assert(res == 18);	

  printf("product_2_f\n");
  product_2_f(&res, 3, 1.5f);
  printf("%i", res);
  assert(res == 4); //4.5f truncado
  product_2_f(&res, 5, 0.2);
  printf(" %i\n", res);
  assert(res == 1); //1.f truncado

  printf("complex_sum_z: ");
  complex_item item1 = {
    .w = 1,
    .x = 2,
    .y = 3,
    .z = 4
  };
  complex_item item2 = {
    .w = 5,
    .x = 6,
    .y = 7,
    .z = 8
  };

  complex_item arr[4] = {item1, item1, item2, item2};
  res = complex_sum_z(arr, 4);
  printf(" %i\n", res);
  assert(res == 24);

  printf("packed_complex_sum_z: ");
  packed_complex_item item1p = {
    .w = 1,
    .x = 2,
    .y = 3,
    .z = 4
  };
  packed_complex_item item2p = {
    .w = 5,
    .x = 6,
    .y = 7,
    .z = 8
  };

  packed_complex_item arrp[4] = {item1p, item1p, item2p, item2p};
  res = packed_complex_sum_z(arrp, 4);
  printf(" %i\n", res);
  assert(res == 24);

  printf("product_9_f:");
  double resd = 0;
  product_9_f(&resd, 1, 1, 2, 2, 3, 3, 4, 4, 5, 5, 6, 6, 7, 7, 8, 8, 9, 9);
  printf(" %f\n", resd);
  /*assert*/

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

	return 0;    
}


