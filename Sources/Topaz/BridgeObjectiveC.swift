public struct AutoreleasingUnsafeMutablePointer<Pointee /* TODO : class */>
:  _Pointer {
    
    public let _rawValue: Builtin.RawPointer
    
    @_transparent
    public // COMPILER_INTRINSIC
    init(_ _rawValue: Builtin.RawPointer) {
        self._rawValue = _rawValue
    }
}
