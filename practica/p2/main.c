#include <stdio.h>
#include <stdlib.h>

#include "stack.h"
#include "student.h"

stack_t *stack;

int main()
{
    stack = createStack(100);

    student_t stud1 = {
        .name = "Steve Balmer",
        .dni = 12345678,
        .califications = {3,2,1},
        .concept = -2,
    };

    studentp_t stud2 = {
        .name = "Linus Torvalds",
        .dni = 23456789,
        .califications = {9,7,8},
        .concept = 1,
    };

    printf("%lu, %lu", sizeof(stud1), sizeof(stud2));

    // Hint: ver 'createFrame'
    stack->createFrame(stack);
    
    // Push student stud2

    /*stack->push(stack, *(uint32_t *)(&stud2)); //A: Como stud2 mide 31 bits, lo casteamos a uint32 y lo pusheamos entero al stack*/
    unsigned numStackPos = sizeof(stud2) / sizeof(uint32_t); //A: Vamos a necesitar separar stud1 en esta cantidad de espacios en el stack = 2
    uint32_t* ebpDir = (uint32_t *) &(stud2); //A: Apuntamos a el primer elemento de stud1 como si fuera un uint32_t

    for (int i=0; i<numStackPos; ++i) //A: Vamos metiendo las partes de stud1 en el stack
        stack->push(stack, ebpDir[i]);

    // Push random value
    uint32_t value = 42;
    stack->push(stack,value);

    // Push student stud1
    
    stack->createFrame(stack);

    numStackPos = sizeof(stud1) / sizeof(uint32_t); //A: Vamos a necesitar separar stud1 en esta cantidad de espacios en el stack = 2
    ebpDir = (uint32_t *) &(stud1); //A: Apuntamos a el primer elemento de stud1 como si fuera un uint32_t

    for (int i=0; i<numStackPos; ++i) //A: Vamos metiendo las partes de stud1 en el stack
        stack->push(stack, ebpDir[i]);

    // Print student st1 y st2

    void (*prStudpt)() = printStudent;
    myCall(stack, prStudpt);

    // A qué apunta el esp???
    printf("Numero random: %i\n", stack->pop(stack));

    prStudpt = printStudentp;
    myCall(stack, prStudpt);


    free(stack); // Alcanza?


    return 0;
}
