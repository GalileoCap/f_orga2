#include "student.h"
#include <stdlib.h>
#include <stdint.h>
#include <stdio.h>


void printStudent()
{
  student_t s;
  uint32_t *sPart = (uint32_t*) (&s);
  unsigned parts = sizeof(s) / sizeof(uint32_t);
  for (int i = parts - 1; i >= 0; i--)
    sPart[i] = stack->pop(stack);

  printf("Name: %s\nDNI: %i\nCalifications: {%i, %i, %i}\nConcept: %i\n\n", s.name, s.dni, s.califications[0], s.califications[1], s.califications[2], s.concept);
}

void printStudentp()
{
  studentp_t s;
  uint32_t *sPart = (uint32_t*) (&s);
  unsigned parts = sizeof(s) / sizeof(uint32_t);
  for (int i = parts - 1; i >= 0; i--)
    sPart[i] = stack->pop(stack);

  printf("Name: %s\nDNI: %i\nCalifications: {%i, %i, %i}\nConcept: %i\n\n", s.name, s.dni, s.califications[0], s.califications[1], s.califications[2], s.concept);
}
