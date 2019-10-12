#include "Config.h"
#include <cstdlib>

SWIFT_CC(swift) extern "C"
const void * _Nullable
swift_getTypeByMangledNameInContext(
                        const char *typeNameStart,
                        size_t typeNameLength,
                        const void *context,
                        const void * const *genericArgs) {

    return 0;
}
