//===----------------------------------------------------------------------===//
// C Primitive Types
//===----------------------------------------------------------------------===//

/// The C '_Bool' and C++ 'bool' type.
public typealias CBool = Bool

/// The C 'char' type.
///
/// This will be the same as either `CSignedChar` (in the common
/// case) or `CUnsignedChar`, depending on the platform.
public typealias CChar = Int8

/// The C 'unsigned char' type.
public typealias CUnsignedChar = UInt8

/// The C 'long long' type.
public typealias CLongLong = Int64

/// The C 'double' type.
public typealias CDouble = Double
