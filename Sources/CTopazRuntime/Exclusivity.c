#include "Exclusivity.h"

void swift_beginAccess(void *pointer, void * /*ValueBuffer * */ buffer,
                       uintptr_t /*ExclusivityFlags*/ flags, void *pc) {
}

char *swift_getFunctionReplacement(char **ReplFnPtr, char *CurrFn) {
  return NULL;
}

char *swift_getOrigOfReplaceable(char **OrigFnPtr) {
  return NULL;
}

void swift_endAccess(void * /*ValueBuffer * */ buffer) {
}
