#include "Exclusivity.h"

extern "C" {
    
void swift_beginAccess(void *pointer, void * /*ValueBuffer * */ buffer,
                       uintptr_t /*ExclusivityFlags*/ flags, void *pc) {
}

char *swift_getFunctionReplacement(char **ReplFnPtr, char *CurrFn) {
  return 0;
}

char *swift_getOrigOfReplaceable(char **OrigFnPtr) {
  return 0;
}

void swift_endAccess(void * /*ValueBuffer * */ buffer) {
}
    
}; // extern "C"
