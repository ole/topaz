#include "HeapObject.h"

extern "C"
void swift_unknownObjectRelease(void *value)
{
}

extern "C"
void *swift_retain(void *object)
{
    return object;
}

