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
}

extension Bool: _ExpressibleByBuiltinBooleanLiteral, ExpressibleByBooleanLiteral {
  public init(_builtinBooleanLiteral value: Builtin.Int1) {
    self._value = value
  }

  public init(booleanLiteral value: Bool) {
    self = value
  }
}

