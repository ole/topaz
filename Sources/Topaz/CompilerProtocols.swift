//===----------------------------------------------------------------------===//
// Intrinsic protocols shared with the compiler
//===----------------------------------------------------------------------===//

public protocol _ExpressibleByBuiltinBooleanLiteral {
  init(_builtinBooleanLiteral value: Builtin.Int1)
}

public protocol ExpressibleByBooleanLiteral {
  associatedtype BooleanLiteralType : _ExpressibleByBuiltinBooleanLiteral
  init(booleanLiteral value: BooleanLiteralType)
}

public protocol ExpressibleByNilLiteral {
  init(nilLiteral: ())
}

public protocol _ExpressibleByBuiltinIntegerLiteral {
  init(_builtinIntegerLiteral value: Builtin.IntLiteral)
}

public protocol ExpressibleByIntegerLiteral {
  associatedtype IntegerLiteralType: _ExpressibleByBuiltinIntegerLiteral
  init(integerLiteral value: IntegerLiteralType)
}

public protocol _ExpressibleByBuiltinFloatLiteral {
  init(_builtinFloatLiteral value: _MaxBuiltinFloatType)
}

public protocol ExpressibleByFloatLiteral {
  associatedtype FloatLiteralType: _ExpressibleByBuiltinFloatLiteral
  init(floatLiteral value: FloatLiteralType)
}

public protocol _ExpressibleByBuiltinStringLiteral {

  init(
    _builtinStringLiteral start: Builtin.RawPointer,
    utf8CodeUnitCount: Builtin.Word,
    isASCII: Builtin.Int1)
}

/// A type that can be initialized with a string literal.
///
/// The `String` and `StaticString` types conform to the
/// `ExpressibleByStringLiteral` protocol. You can initialize a variable or
/// constant of either of these types using a string literal of any length.
///
///     let picnicGuest = "Deserving porcupine"
///
/// Conforming to ExpressibleByStringLiteral
/// ========================================
///
/// To add `ExpressibleByStringLiteral` conformance to your custom type,
/// implement the required initializer.
public protocol ExpressibleByStringLiteral {
  
  /// A type that represents a string literal.
  ///
  /// Valid types for `StringLiteralType` are `String` and `StaticString`.
  associatedtype StringLiteralType: _ExpressibleByBuiltinStringLiteral
  
  /// Creates an instance initialized to the given string value.
  ///
  /// - Parameter value: The value of the new instance.
  init(stringLiteral value: StringLiteralType)
}
