public struct UInt {
    var _value: Builtin.Int64
}

extension UInt : _ExpressibleByBuiltinIntegerLiteral, ExpressibleByIntegerLiteral {
    public init(_builtinIntegerLiteral x: Builtin.IntLiteral) {
      _value = Builtin.s_to_u_checked_trunc_IntLiteral_Int64(x).0
    }

    public init(integerLiteral value: UInt) {
      self = value
    }
}

extension UInt : _ExpressibleByBuiltinFloatLiteral, ExpressibleByFloatLiteral {
    public init(_builtinFloatLiteral value: _MaxBuiltinFloatType) {
        self._value = Builtin.fptoui_FPIEEE64_Int64(value)
    }
    
    public init(floatLiteral value: Double) {
        self._value = Builtin.fptoui_FPIEEE64_Int64(value._value)
    }
}

extension UInt {
  var _builtinWordValue: Builtin.Word {
    return Builtin.truncOrBitCast_Int64_Word(_value)
  }
}

extension UInt {
    public static func == (lhs: UInt, rhs: UInt) -> Bool {
      return Bool(Builtin.cmp_eq_Int64(lhs._value, rhs._value))
    }
}
