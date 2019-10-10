#ifndef Enum_h
#define Enum_h

#include "Config.h"
#include "MetadataValues.h"

extern "C" unsigned
swift_getEnumTagSinglePayloadGeneric(const void *value,
    unsigned emptyCases,
    const void *payloadType,
    void *getExtraInhabitantTag);

extern "C"
void swift_initEnumMetadataSinglePayload(void *enumType, //EnumMetadata
                                         EnumLayoutFlags flags,
                                         const void *payload, //TypeLayout
                                         unsigned emptyCases);

extern "C" SWIFT_CC(swift)
void swift_storeEnumTagSinglePayloadGeneric(void *value, // OpaqueValue
                                            unsigned whichCase,
                                            unsigned emptyCases,
                                            const void *payloadType, // Metadata
                                            void *storeTag /* storeExtraInhabitantTag_t */);

#endif
