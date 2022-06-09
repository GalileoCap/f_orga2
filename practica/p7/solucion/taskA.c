#include "syscall.h"
#include "stdbool.h"
#include "colors.h"
#include "i386.h"

#define KEY_SIZE 5
#define LEFT_MARGIN 0
#define TOP_MARGIN 15


void task(void) {
  __asm volatile("xchg %bx, %bx");
  __asm volatile("mov $0x13, %eax");
  __asm volatile("push %eax");
  __asm volatile("int $0x4E");
  __asm volatile("pop %eax");

  while (true) {
	  __asm volatile("nop");
  }
}
