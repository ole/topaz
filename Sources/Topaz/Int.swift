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
