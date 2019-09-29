/// Stubs for swift/Runtime/Metadata.h

#ifndef Metadata_h
#define Metadata_h

#include <stdlib.h>
#include <stddef.h>

/// Fetch a uniqued type metadata for an ObjC class.
extern "C" void * /* const Metadata * */
swift_getObjCClassMetadata(void /* const ClassMetadata *theClass */);

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
