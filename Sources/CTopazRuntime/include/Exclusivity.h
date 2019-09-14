//===----------------------------------------------------------------------===//
//
// Swift runtime support for dynamic checking of the Law of Exclusivity.
//
//===----------------------------------------------------------------------===//

// Dummy implementations for swift/Runtime/Exclusivity.h

#ifndef Exclusivity_h
#define Exclusivity_h

#include <stdint.h>

/// Begin dynamically tracking an access.
///
/// The buffer is opaque scratch space that the runtime may use for
/// the duration of the access.
///
/// The PC argument is an instruction pointer to associate with the start
/// of the access.  If it is null, the return address of the call to
/// swift_beginAccess will be used.
void swift_beginAccess(void *pointer, void * /*ValueBuffer * */ buffer,
                       uintptr_t /*ExclusivityFlags*/ flags, void *pc);

/// Loads the replacement function pointer from \p ReplFnPtr and returns the
/// replacement function if it should be called.
/// Returns null if the original function (which is passed in \p CurrFn) should
/// be called.
char *swift_getFunctionReplacement(char **ReplFnPtr, char *CurrFn);

/// Returns the original function of a replaced function, which is loaded from
/// \p OrigFnPtr.
/// This function is called from a replacement function to call the original
/// function.
char *swift_getOrigOfReplaceable(char **OrigFnPtr);

/// Stop dynamically tracking an access.
void swift_endAccess(void * /*ValueBuffer * */ buffer);

#endif // Exclusivity_h
