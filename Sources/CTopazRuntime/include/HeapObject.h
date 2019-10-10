#ifndef HeapObject_h
#define HeapObject_h

#include <cstdlib>

// Allocate plain old memory. This is the generalized entry point
// Never returns nil. The returned memory is uninitialized.
//
// An "alignment mask" is just the alignment (a power of 2) minus 1.

extern "C"
void *swift_slowAlloc(size_t bytes, size_t alignMask);

// If the caller cannot promise to zero the object during destruction,
// then call these corresponding APIs:
extern "C"
void swift_slowDealloc(void *ptr, size_t bytes, size_t alignMask);

/// Atomically increments the retain count of an object.
///
/// \param object - may be null, in which case this is a no-op
///
/// \return object - we return the object because this enables tail call
/// optimization and the argument register to be live through the call on
/// architectures whose argument and return register is the same register.
///
/// POSSIBILITIES: We may end up wanting a bunch of different variants:
///  - the general version which correctly handles null values, swift
///     objects, and ObjC objects
///    - a variant that assumes that its operand is a swift object
///      - a variant that can safely use non-atomic operations
///      - maybe a variant that can assume a non-null object
/// It may also prove worthwhile to have this use a custom CC
/// which preserves a larger set of registers.
extern "C"
void *swift_retain(void *object);

#endif
