import CTopazLib

public struct UnsafeRawPointer: _Pointer {
    
    public typealias Pointee = UInt8
    
    /// The underlying raw pointer.
    /// Implements conformance to the public protocol `_Pointer`.
    public let _rawValue: Builtin.RawPointer
    
    /// Creates a new raw pointer from a builtin raw pointer.
//    @_transparent
    public init(_ _rawValue: Builtin.RawPointer) {
        self._rawValue = _rawValue
    }
}

public struct UnsafeMutableRawPointer: _Pointer {
    
    public typealias Pointee = UInt8
    
    /// The underlying raw pointer.
    /// Implements conformance to the public protocol `_Pointer`.
    public let _rawValue: Builtin.RawPointer
    
    /// Creates a new raw pointer from a builtin raw pointer.
//    @_transparent
    public init(_ _rawValue: Builtin.RawPointer) {
        self._rawValue = _rawValue
    }
}

public func printPointer(_ ptr: UnsafeMutableRawPointer?) -> UnsafeMutableRawPointer?
{
    return CTopazLib.printPointer(ptr)
}
