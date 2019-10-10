public enum Optional<Wrapped> : ExpressibleByNilLiteral {
    public init(nilLiteral: ()) {
        self = .none
    }

  // The compiler has special knowledge of Optional<Wrapped>, including the fact
  // that it is an `enum` with cases named `none` and `some`.

  /// The absence of a value.
  ///
  /// In code, the absence of a value is typically written using the `nil`
  /// literal rather than the explicit `.none` enumeration case.
  case none

  /// The presence of a value, stored as `Wrapped`.
  case some(Wrapped)

  /// Creates an instance that stores the given value.
  public init(_ some: Wrapped) { self = .some(some) }
}

public // COMPILER_INTRINSIC
func _diagnoseUnexpectedNilOptional(_filenameStart: Builtin.RawPointer,
                                    _filenameLength: Builtin.Word,
                                    _filenameIsASCII: Builtin.Int1,
                                    _line: Builtin.Word,
                                    _isImplicitUnwrap: Builtin.Int1) {
  // Cannot use _preconditionFailure as the file and line info would not be
  // printed.
//  if Bool(_isImplicitUnwrap) {
//    _preconditionFailure(
//      "Unexpectedly found nil while implicitly unwrapping an Optional value",
//      file: StaticString(_start: _filenameStart,
//                         utf8CodeUnitCount: _filenameLength,
//                         isASCII: _filenameIsASCII),
//      line: UInt(_line))
//  } else {
//    _preconditionFailure(
//      "Unexpectedly found nil while unwrapping an Optional value",
//      file: StaticString(_start: _filenameStart,
//                         utf8CodeUnitCount: _filenameLength,
//                         isASCII: _filenameIsASCII),
//      line: UInt(_line))
//  }
}
