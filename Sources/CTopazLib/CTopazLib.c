#include <stdio.h>

void printBool(_Bool b)
{
    printf(b ? "true\n" : "false\n");
}

void printInt64(long long v)
{
    printf("%lld\n", v);
}

void printDouble(double v)
{
    printf("%f\n", v);
}

void* printPointer(void *pointer)
{
    printf("%p\n", pointer);
    
    return pointer;
}

void printString(const char *p)
{
    printf("%s\n", p);
}
