//===----------------------------------------------------------------------===//
// Swift Standard Prolog Library.
//===----------------------------------------------------------------------===//

//===----------------------------------------------------------------------===//
// Standardized aliases
//===----------------------------------------------------------------------===//

public typealias Void = ()

//===----------------------------------------------------------------------===//
// Default types for unconstrained literals
//===----------------------------------------------------------------------===//

public typealias IntegerLiteralType = Int
public typealias FloatLiteralType = Double
public typealias BooleanLiteralType = Bool

//===----------------------------------------------------------------------===//
// Default types for unconstrained number literals
//===----------------------------------------------------------------------===//
public typealias _MaxBuiltinFloatType = Builtin.FPIEEE64

public typealias AnyObject = Builtin.AnyObject

//===----------------------------------------------------------------------===//
// Standard precedence groups
//===----------------------------------------------------------------------===//

precedencegroup AssignmentPrecedence {
  assignment: true
  associativity: right
}
precedencegroup FunctionArrowPrecedence {
  associativity: right
  higherThan: AssignmentPrecedence
}
precedencegroup TernaryPrecedence {
  associativity: right
  higherThan: FunctionArrowPrecedence
}
precedencegroup DefaultPrecedence {
  higherThan: TernaryPrecedence
}
precedencegroup LogicalDisjunctionPrecedence {
  associativity: left
  higherThan: TernaryPrecedence
}
precedencegroup LogicalConjunctionPrecedence {
  associativity: left
  higherThan: LogicalDisjunctionPrecedence
}
precedencegroup ComparisonPrecedence {
  higherThan: LogicalConjunctionPrecedence
}
precedencegroup NilCoalescingPrecedence {
  associativity: right
  higherThan: ComparisonPrecedence
}
precedencegroup CastingPrecedence {
  higherThan: NilCoalescingPrecedence
}
precedencegroup RangeFormationPrecedence {
  higherThan: CastingPrecedence
}
precedencegroup AdditionPrecedence {
  associativity: left
  higherThan: RangeFormationPrecedence
}
precedencegroup MultiplicationPrecedence {
  associativity: left
  higherThan: AdditionPrecedence
}
precedencegroup BitwiseShiftPrecedence {
  higherThan: MultiplicationPrecedence
}

// Standard prefix operators.
prefix operator ! : Bool

// "Multiplicative"

infix operator   *: MultiplicationPrecedence
infix operator  &*: MultiplicationPrecedence
infix operator   /: MultiplicationPrecedence
infix operator   %: MultiplicationPrecedence
infix operator   &: MultiplicationPrecedence

// "Additive"

infix operator   +: AdditionPrecedence
infix operator  &+: AdditionPrecedence
infix operator   -: AdditionPrecedence
infix operator  &-: AdditionPrecedence
infix operator   |: AdditionPrecedence
infix operator   ^: AdditionPrecedence

// "Comparative"

infix operator  <  : ComparisonPrecedence, Comparable
infix operator  <= : ComparisonPrecedence, Comparable
infix operator  >  : ComparisonPrecedence, Comparable
infix operator  >= : ComparisonPrecedence, Comparable
infix operator  == : ComparisonPrecedence, Equatable
infix operator  != : ComparisonPrecedence, Equatable
infix operator === : ComparisonPrecedence
infix operator !== : ComparisonPrecedence

// Compound

infix operator   *=: AssignmentPrecedence
infix operator  &*=: AssignmentPrecedence
infix operator   /=: AssignmentPrecedence
infix operator   %=: AssignmentPrecedence
infix operator   +=: AssignmentPrecedence
infix operator  &+=: AssignmentPrecedence
infix operator   -=: AssignmentPrecedence
infix operator  &-=: AssignmentPrecedence
infix operator  <<=: AssignmentPrecedence
infix operator &<<=: AssignmentPrecedence
infix operator  >>=: AssignmentPrecedence
infix operator &>>=: AssignmentPrecedence
infix operator   &=: AssignmentPrecedence
infix operator   ^=: AssignmentPrecedence
infix operator   |=: AssignmentPrecedence
