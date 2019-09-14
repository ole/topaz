/// Dummy implementations for swift/Runtime/Exclusivity.h

#ifndef Exclusivity_h
#define Exclusivity_h

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

#endif // Exclusivity_h
