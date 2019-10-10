/// Stubs for swift/Runtime/Metadata.h

#ifndef Metadata_h
#define Metadata_h

#include <stdlib.h>
#include <stddef.h>
#include "Config.h"
#include "MetadataValues.h"

struct TypeContextDescriptor {
    uint32_t Flags;
    void *Parent;
};

/// The result of requesting type metadata.  Generally the return value of
/// a function.
///
/// For performance and ABI matching across Swift/C++, functions returning
/// this type must use SWIFT_CC so that the components are returned as separate
/// values.
struct MetadataResponse {
  /// The requested metadata.
  const void *Value; // Metadata *

  /// The current state of the metadata returned.  Always use this
  /// instead of trying to inspect the metadata directly to see if it
  /// satisfies the request.  An incomplete metadata may be getting
  /// initialized concurrently.  But this can generally be ignored if
  /// the metadata request was for abstract metadata or if the request
  /// is blocking.
  MetadataState State;
};

/// Kinds of requests for metadata.
class MetadataRequest {
public:
    size_t Bits;
};

/// Fetch a uniqued type metadata for an ObjC class.
extern "C" void * /* const Metadata * */
swift_getObjCClassMetadata(void /* const ClassMetadata *theClass */);

/// Allocate a generic value metadata object.  This is intended to be
/// called by the metadata instantiation function of a generic struct or
/// enum.

extern "C" void *//ValueMetadata *
swift_allocateGenericValueMetadata(const void *description,
                                   const void *arguments,
                                   const void *pattern,
                                   size_t extraDataSize);

/// Check that the given metadata has the right state.
extern "C" SWIFT_CC(swift)
MetadataResponse swift_checkMetadataState(MetadataRequest request,
                                          const void *type);

/// Retrieve an associated type witness from the given witness table.
///
/// \param wtable The witness table.
/// \param conformingType Metadata for the conforming type.
/// \param reqBase "Base" requirement used to compute the witness index
/// \param assocType Associated type descriptor.
///
/// \returns metadata for the associated type witness.
extern "C" SWIFT_CC(swift)
MetadataResponse swift_getAssociatedTypeWitness(
                                          MetadataRequest request,
                                          void *wtable,
                                          const void *conformingType,
                                          const void *reqBase,
                                          const void *assocType);

extern "C" SWIFT_CC(swift)
MetadataResponse
swift_getGenericMetadata(MetadataRequest request,
                         const void * const *arguments,
                         const TypeContextDescriptor *description);



typedef uint32_t ValueWitnessFlags;

struct ValueWitnessTable {
    void (*initializeBufferWithCopyOfBuffer)();
    void (*destroy)(void *object, const void *metadata);
    void *(*initializeWithCopy)(void *dest, void *src, const void *metadata);
    void *(*assignWithCopy)(void *dest, void *src, const void *metadata);
    void *(*initializeWithTake)(void *dest, void *src, const void *metadata);
    void *(*assignWithTake)(void *dest, void *src, const void *metadata);
    
    void *(*getEnumTagSinglePayload)();
    void (*storeEnumTagSinglePayload)();
    void *(*getEnumTag)();
    void *(*destructiveProjectEnumData);
    void (*destructiveInjectEnumTag)();
    
    size_t size;
    size_t stride;
    ValueWitnessFlags flags;
    uint32_t extraInhabitantCount;
    
};

extern "C" __attribute__((__visibility__("default"))) const ValueWitnessTable $sBi8_WV;
extern "C" __attribute__((__visibility__("default"))) const ValueWitnessTable $sBi64_WV;

extern "C" __attribute__((__visibility__("default"))) const ValueWitnessTable $sBf64_WV;

#endif // Metadata_h
