#include "syscall.h"
#include "stdbool.h"
#include "colors.h"

#define SHARED_MEMORY_SIZE 32
#define PAGE_SIZE 4096
#define KEY_SIZE 5

#define LEFT_MARGIN 0
#define TOP_MARGIN 15


void task(void) {
  __asm volatile("mov $0x33, %eax");
  __asm volatile("push %eax");
  __asm volatile("int $0x4E");
  __asm volatile("pop %eax");

  while (true) {
    __asm volatile("nop");
  }
}
