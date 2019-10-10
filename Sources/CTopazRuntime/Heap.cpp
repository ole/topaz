#include "HeapObject.h"

extern "C"
void *swift_slowAlloc(size_t bytes, size_t alignMask) {
    void *p = malloc(bytes);

    return p;
}

extern "C"
void swift_slowDealloc(void *ptr, size_t bytes, size_t alignMask) {
    free(ptr);
}
