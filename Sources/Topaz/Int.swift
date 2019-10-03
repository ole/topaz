import CTopazLib

public func printInt(_ v: Int) {
    CTopazLib.printInt64(Int64(v))
}

public struct Int {
    var _value: Builtin.Int64
}

extension Int : _ExpressibleByBuiltinIntegerLiteral, ExpressibleByIntegerLiteral {
    public init(_builtinIntegerLiteral value: Builtin.IntLiteral) {
        self._value = Builtin.s_to_s_checked_trunc_IntLiteral_Int64(value).0
    }

    public init(integerLiteral value: Int) {
      self = value
    }
}

extension Int : _ExpressibleByBuiltinFloatLiteral, ExpressibleByFloatLiteral {
    public init(_builtinFloatLiteral value: _MaxBuiltinFloatType) {
        self._value = Builtin.fptoui_FPIEEE64_Int64(value)
    }
    
    public init(floatLiteral value: Double) {
        self._value = Builtin.fptosi_FPIEEE64_Int64(value._value)
    }
}

extension Int {
  var _builtinWordValue: Builtin.Word {
    return Builtin.truncOrBitCast_Int64_Word(_value)
  }
}

extension Int {
    public static func == (lhs: Int, rhs: Int) -> Bool {
      return Bool(Builtin.cmp_eq_Int64(lhs._value, rhs._value))
    }
}
