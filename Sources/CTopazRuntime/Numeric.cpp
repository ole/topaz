#include "Numeric.h"

extern "C" double swift_intToFloat64(void *value)
{
    long long v = *(long long *)value;
    return (double)v;
}
