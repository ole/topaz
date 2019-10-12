import CTopazLib

public struct String  {
    enum StringStorage {
        case literalUTF8(Builtin.RawPointer, Int)
    }
    
    var storage: StringStorage
}

extension String {
    internal var utf8CPointer: Builtin.RawPointer {
        switch self.storage {
        case .literalUTF8(let pointer, _):
            return pointer
        }
    }
}
extension String: _ExpressibleByBuiltinStringLiteral {
//  @inlinable @inline(__always)
//  @_effects(readonly) @_semantics("string.makeUTF8")
  public init(
    _builtinStringLiteral start: Builtin.RawPointer,
    utf8CodeUnitCount: Builtin.Word,
    isASCII: Builtin.Int1
    ) {
    self.storage = StringStorage.literalUTF8(start, Int(utf8CodeUnitCount))
//    let bufPtr = UnsafeBufferPointer(
//      start: UnsafeRawPointer(start).assumingMemoryBound(to: UInt8.self),
//      count: Int(utf8CodeUnitCount))
//    if let smol = _SmallString(bufPtr) {
//      self = String(_StringGuts(smol))
//      return
//    }
//    self.init(_StringGuts(bufPtr, isASCII: Bool(isASCII)))
  }
}

extension String: ExpressibleByStringLiteral {
  /// Creates an instance initialized to the given string value.
  ///
  /// Do not call this initializer directly. It is used by the compiler when you
  /// initialize a string using a string literal. For example:
  ///
  ///     let nextStop = "Clark & Lake"
  ///
  /// This assignment to the `nextStop` constant calls this string literal
  /// initializer behind the scenes.
//  @inlinable @inline(__always)
  public init(stringLiteral value: String) {
    self = value
  }
}

public func printString(_ str: String) {
    CTopazLib.printString(UnsafeRawPointer(str.utf8CPointer).assumingMemoryBound(to: Int8.self))
}
