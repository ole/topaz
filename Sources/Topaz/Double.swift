import CTopazLib

public func printDouble(_ v: Double) {
    CTopazLib.printDouble(v);
}

public struct Double {
    var _value: Builtin.FPIEEE64

    public // @testable
    init(_ _value: Builtin.FPIEEE64) {
      self._value = _value
    }
}

extension Double : _ExpressibleByBuiltinIntegerLiteral, ExpressibleByIntegerLiteral {
    public init(_builtinIntegerLiteral value: Builtin.IntLiteral){
      self = Double(Builtin.itofp_with_overflow_IntLiteral_FPIEEE64(value))
    }

    public init(integerLiteral value: Int64) {
      self = Double(Builtin.sitofp_Int64_FPIEEE64(value._value))
    }

}

extension Double : _ExpressibleByBuiltinFloatLiteral {
  @_transparent
  public
  init(_builtinFloatLiteral value: Builtin.FPIEEE64) {
    self = Double(value)
  }
}

extension Double : ExpressibleByFloatLiteral {
    public init(floatLiteral value: Double) {
        self = value
    }
}
