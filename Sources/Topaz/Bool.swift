//===----------------------------------------------------------------------===//
// Bool Datatype and Supporting Operators
//===----------------------------------------------------------------------===//

import CTopazLib

public func printBool(_ v: Bool) {
    CTopazLib.printBool(v)
}

// Our Boolean type must also be named Bool because that name is hardcoded into
// the compiler to be used e.g. in conditional expressions.
public struct Bool {
  internal var _value: Builtin.Int1
    
  public init() {
    let zero: Int8 = 0
    self._value = Builtin.trunc_Int8_Int1(zero._value)
  }

  internal init(_ v: Builtin.Int1) { self._value = v }
    
  @inlinable
  public init(_ value: Bool) {
    self = value
  }
}

extension Bool: _ExpressibleByBuiltinBooleanLiteral, ExpressibleByBooleanLiteral {
  public init(_builtinBooleanLiteral value: Builtin.Int1) {
    self._value = value
  }

  public init(booleanLiteral value: Bool) {
    self = value
  }
}

//===----------------------------------------------------------------------===//
// Operators
//===----------------------------------------------------------------------===//

extension Bool {
  public static prefix func ! (a: Bool) -> Bool {
    return Bool(Builtin.xor_Int1(a._value, true._value))
  }
}
