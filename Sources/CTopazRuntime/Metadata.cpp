#include "Metadata.h"

#include <stdlib.h>
#include <string.h>
#include <stdio.h>

extern "C" void *swift_getObjCClassMetadata(void) {
  return NULL;
}

extern "C" void *//ValueMetadata *
swift_allocateGenericValueMetadata(const void *description,
                                   const void *arguments,
                                   const void *pattern,
                                   size_t extraDataSize)
{
    return 0;
}

extern "C" SWIFT_CC(swift)
MetadataResponse swift_checkMetadataState(MetadataRequest request,
                                          const void *type)
{
    MetadataResponse response = {type, MetadataState::Complete};
    
    return response;
}

extern "C" SWIFT_CC(swift)
MetadataResponse
swift_getGenericMetadata(MetadataRequest request,
                         const void * const *arguments,
                         const TypeContextDescriptor *description)
{
    MetadataResponse response = {NULL, MetadataState::Complete};
    
    return response;
}

extern "C"
void swift_initEnumMetadataSinglePayload(void *enumType, //EnumMetadata
                                         EnumLayoutFlags flags,
                                         const void *payload, //TypeLayout
                                         unsigned emptyCases)
{
    
}

extern "C" SWIFT_CC(swift)
MetadataResponse
swift_getAssociatedTypeWitness(MetadataRequest request,
                               void *wtable,
                               const void *conformingType,
                               const void *reqBase,
                               const void *assocType) {

    MetadataResponse response = {NULL, MetadataState::Complete};
    
    return response;
}



static ValueWitnessTable *getValueWitnessTable(const void *metadata) {
    return *((ValueWitnessTable **)metadata - 1);
}

void pod_destroy(void *object, const void *metadata) {
    
}

void *pod_copy(void *dest, void *src, const void *metadata) {
    
    ValueWitnessTable *valueWitnessTable = getValueWitnessTable(metadata);
    memcpy(dest, src, valueWitnessTable->size);
    
    return dest;
}

constexpr ValueWitnessTable pod_table_with_size_and_stride(int size, int stride) {
    ValueWitnessTable pod_table = {
        0,
        .destroy = pod_destroy,
        .initializeWithCopy = pod_copy,
        .assignWithCopy = pod_copy,
        .initializeWithTake = pod_copy,
        .assignWithTake = pod_copy,
        
        0,
        0,
        0,
        0,
        0,
        
        8, // size
        8, // stride
        0, // flags
        0,
    };

    pod_table.size = size;
    pod_table.stride = stride;
    
    return pod_table;
}

template<typename type>struct TargetValueWitnessTable {
    static constexpr ValueWitnessTable table() {
        return pod_table_with_size_and_stride(sizeof(type), alignof(type));
    }
};

const ValueWitnessTable $sBi8_WV  = TargetValueWitnessTable<uint8_t>::table(); // (U)Int8
const ValueWitnessTable $sBi64_WV = TargetValueWitnessTable<int64_t>::table(); // (U)Int64
const ValueWitnessTable $sBf64_WV = TargetValueWitnessTable<double>::table(); // Double


