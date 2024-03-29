public struct Int8 {
    var _value: Builtin.Int8
}

extension Int8 : _ExpressibleByBuiltinIntegerLiteral, ExpressibleByIntegerLiteral {
    public init(_builtinIntegerLiteral value: Builtin.IntLiteral) {
        self._value = Builtin.s_to_s_checked_trunc_IntLiteral_Int8(value).0
    }

    public init(integerLiteral value: Int8) {
      self = value
    }
}

extension Int8 : _ExpressibleByBuiltinFloatLiteral, ExpressibleByFloatLiteral {
    public init(_builtinFloatLiteral value: _MaxBuiltinFloatType) {
        self._value = Builtin.fptosi_FPIEEE64_Int8(value)
    }
    
    public init(floatLiteral value: Double) {
        self._value = Builtin.fptosi_FPIEEE64_Int8(value._value)
    }
}
