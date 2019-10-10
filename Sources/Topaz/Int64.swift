import CTopazLib

public func printInt64(_ v: Int64) {
    CTopazLib.printInt64(v)
}

public struct Int64 {
    public var _value: Builtin.Int64
}

extension Int64 : _ExpressibleByBuiltinIntegerLiteral, ExpressibleByIntegerLiteral {
    public init(_builtinIntegerLiteral x: Builtin.IntLiteral) {
        self._value = Builtin.s_to_s_checked_trunc_IntLiteral_Int64(x).0
    }
    
    public init(integerLiteral value: Int64) {
        self = value
    }
}

extension Int64 : _ExpressibleByBuiltinFloatLiteral, ExpressibleByFloatLiteral {
    public init(_builtinFloatLiteral value: _MaxBuiltinFloatType) {
        self._value = Builtin.fptosi_FPIEEE64_Int64(value)
    }
    
    public init(floatLiteral value: Double) {
        self._value = Builtin.fptosi_FPIEEE64_Int64(value._value)
    }
}

extension Int64 {
    public init(_ source: Double) {
        self._value = Builtin.fptosi_FPIEEE64_Int64(source._value)
    }

    public init(_ source: Int) {
        self._value = source._value
    }
}
