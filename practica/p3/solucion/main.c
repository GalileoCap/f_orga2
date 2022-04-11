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

  /*printf("alternate_sum_8\n");*/
  /*product_2_f(&res, 3, 1.5f);*/
  /*printf("%i", res);*/
  /*assert(res == 4); //4.5f truncado*/
  /*product_2_f(&res, 5, 0.2);*/
  /*printf(" %i\n", res);*/
  /*assert(res == 1); //1.f truncado*/

	return 0;    
}


