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
