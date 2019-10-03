#include "Enum.h"

extern "C" unsigned
swift_getEnumTagSinglePayloadGeneric(const void *value,
    unsigned emptyCases,
    const void *payloadType,
    void *getExtraInhabitantTag)
{
    return 0;
}

extern "C" SWIFT_CC(swift)
void swift_storeEnumTagSinglePayloadGeneric(void *value, // OpaqueValue
                                            unsigned whichCase,
                                            unsigned emptyCases,
                                            const void *payloadType, // Metadata
                                            void *storeTag /* storeExtraInhabitantTag_t */)
{
    
}

