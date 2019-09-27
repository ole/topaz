#include <stdio.h>

void printBool(_Bool b)
{
    printf(b ? "true\n" : "false\n");
}

void printInt64(long long v)
{
    printf("%lld\n", v);
}
