public protocol _Pointer {
  /// A type that represents the distance between two pointers.
  typealias Distance = Int
  
  associatedtype Pointee

  /// The underlying raw pointer value.
  var _rawValue: Builtin.RawPointer { get }

  /// Creates a pointer from a raw value.
  init(_ _rawValue: Builtin.RawPointer)
}

extension _Pointer {
//  /// Creates a new typed pointer from the given opaque pointer.
//  ///
//  /// - Parameter from: The opaque pointer to convert to a typed pointer.
//  @_transparent
//  public init(_ from : OpaquePointer) {
//    self.init(from._rawValue)
//  }
//
//  /// Creates a new typed pointer from the given opaque pointer.
//  ///
//  /// - Parameter from: The opaque pointer to convert to a typed pointer. If
//  ///   `from` is `nil`, the result of this initializer is `nil`.
//  @_transparent
//  public init?(_ from : OpaquePointer?) {
//    guard let unwrapped = from else { return nil }
//    self.init(unwrapped)
//  }

  /// Creates a new pointer from the given address, specified as a bit
  /// pattern.
  ///
  /// The address passed as `bitPattern` must have the correct alignment for
  /// the pointer's `Pointee` type. That is,
  /// `bitPattern % MemoryLayout<Pointee>.alignment` must be `0`.
  ///
  /// - Parameter bitPattern: A bit pattern to use for the address of the new
  ///   pointer. If `bitPattern` is zero, the result is `nil`.
  public init?(bitPattern: Int) {
    if bitPattern == 0 { return nil }
    self.init(Builtin.inttoptr_Word(bitPattern._builtinWordValue))
  }

  /// Creates a new pointer from the given address, specified as a bit
  /// pattern.
  ///
  /// The address passed as `bitPattern` must have the correct alignment for
  /// the pointer's `Pointee` type. That is,
  /// `bitPattern % MemoryLayout<Pointee>.alignment` must be `0`.
  ///
  /// - Parameter bitPattern: A bit pattern to use for the address of the new
  ///   pointer. If `bitPattern` is zero, the result is `nil`.
  public init?(bitPattern: UInt) {
    if bitPattern == 0 { return nil }
    self.init(Builtin.inttoptr_Word(bitPattern._builtinWordValue))
  }

  /// Creates a new pointer from the given pointer.
  ///
  /// - Parameter other: The typed pointer to convert.
  @_transparent
  public init(_ other: Self) {
    self.init(other._rawValue)
  }

  /// Creates a new pointer from the given pointer.
  ///
  /// - Parameter other: The typed pointer to convert. If `other` is `nil`, the
  ///   result is `nil`.
  @_transparent
  public init?(_ other: Self?) {
    guard let unwrapped = other else { return nil }
    self.init(unwrapped._rawValue)
  }
}

// well, this is pretty annoying
extension _Pointer /*: Equatable */ {
  // - Note: This may be more efficient than Strideable's implementation
  //   calling self.distance().
  /// Returns a Boolean value indicating whether two pointers are equal.
  ///
  /// - Parameters:
  ///   - lhs: A pointer.
  ///   - rhs: Another pointer.
  /// - Returns: `true` if `lhs` and `rhs` reference the same memory address;
  ///   otherwise, `false`.
  public static func == (lhs: Self, rhs: Self) -> Bool {
    return Bool(Builtin.cmp_eq_RawPointer(lhs._rawValue, rhs._rawValue))
  }
}

extension _Pointer /*: Comparable */ {
  // - Note: This is an unsigned comparison unlike Strideable's
  //   implementation.
  /// Returns a Boolean value indicating whether the first pointer references
  /// an earlier memory location than the second pointer.
  ///
  /// - Parameters:
  ///   - lhs: A pointer.
  ///   - rhs: Another pointer.
  /// - Returns: `true` if `lhs` references a memory address earlier than
  ///   `rhs`; otherwise, `false`.
  public static func < (lhs: Self, rhs: Self) -> Bool {
    return Bool(Builtin.cmp_ult_RawPointer(lhs._rawValue, rhs._rawValue))
  }
}

extension _Pointer /*: Strideable*/ {
  /// Returns a pointer to the next consecutive instance.
  ///
  /// The resulting pointer must be within the bounds of the same allocation as
  /// this pointer.
  ///
  /// - Returns: A pointer advanced from this pointer by
  ///   `MemoryLayout<Pointee>.stride` bytes.
  public func successor() -> Self {
    return advanced(by: 1)
  }

  /// Returns a pointer to the previous consecutive instance.
  ///
  /// The resulting pointer must be within the bounds of the same allocation as
  /// this pointer.
  ///
  /// - Returns: A pointer shifted backward from this pointer by
  ///   `MemoryLayout<Pointee>.stride` bytes.
  @_transparent
  public func predecessor() -> Self {
    return advanced(by: -1)
  }

  /// Returns the distance from this pointer to the given pointer, counted as
  /// instances of the pointer's `Pointee` type.
  ///
  /// With pointers `p` and `q`, the result of `p.distance(to: q)` is
  /// equivalent to `q - p`.
  ///
  /// Typed pointers are required to be properly aligned for their `Pointee`
  /// type. Proper alignment ensures that the result of `distance(to:)`
  /// accurately measures the distance between the two pointers, counted in
  /// strides of `Pointee`. To find the distance in bytes between two
  /// pointers, convert them to `UnsafeRawPointer` instances before calling
  /// `distance(to:)`.
  ///
  /// - Parameter end: The pointer to calculate the distance to.
  /// - Returns: The distance from this pointer to `end`, in strides of the
  ///   pointer's `Pointee` type. To access the stride, use
  ///   `MemoryLayout<Pointee>.stride`.
//  public func distance(to end: Self) -> Int {
//    return
//      Int(Builtin.sub_Word(Builtin.ptrtoint_Word(end._rawValue),
//                           Builtin.ptrtoint_Word(_rawValue)))
//    // FIXME: Implement MemoryLayout
//    //MemoryLayout<Pointee>.stride
//  }

  /// Returns a pointer offset from this pointer by the specified number of
  /// instances.
  ///
  /// With pointer `p` and distance `n`, the result of `p.advanced(by: n)` is
  /// equivalent to `p + n`.
  ///
  /// The resulting pointer must be within the bounds of the same allocation as
  /// this pointer.
  ///
  /// - Parameter n: The number of strides of the pointer's `Pointee` type to
  ///   offset this pointer. To access the stride, use
  ///   `MemoryLayout<Pointee>.stride`. `n` may be positive, negative, or
  ///   zero.
  /// - Returns: A pointer offset from this pointer by `n` instances of the
  ///   `Pointee` type.
  public func advanced(by n: Int) -> Self {
    return Self(Builtin.gep_Word(
      self._rawValue, n._builtinWordValue, Pointee.self))
  }
}

//extension _Pointer /*: Hashable */ {
//  @inlinable
//  public func hash(into hasher: inout Hasher) {
//    hasher.combine(UInt(bitPattern: self))
//  }
//
//  @inlinable
//  public func _rawHashValue(seed: Int) -> Int {
//    return Hasher._hash(seed: seed, UInt(bitPattern: self))
//  }
//}
//
//extension _Pointer /*: CustomDebugStringConvertible */ {
//  /// A textual representation of the pointer, suitable for debugging.
//  public var debugDescription: String {
//    return _rawPointerToString(_rawValue)
//  }
//}
//
//extension _Pointer /*: CustomReflectable */ {
//  public var customMirror: Mirror {
//    let ptrValue = UInt64(
//      bitPattern: Int64(Int(Builtin.ptrtoint_Word(_rawValue))))
//    return Mirror(self, children: ["pointerValue": ptrValue])
//  }
//}

//extension Int {
//  public init<P: _Pointer>(bitPattern pointer: P?) {
//    if let pointer = pointer {
//      self = Int(Builtin.ptrtoint_Word(pointer._rawValue))
//    } else {
//      self = 0
//    }
//  }
//}
//
//extension UInt {
//  public init<P: _Pointer>(bitPattern pointer: P?) {
//    if let pointer = pointer {
//      self = UInt(Builtin.ptrtoint_Word(pointer._rawValue))
//    } else {
//      self = 0
//    }
//  }
//}

//public // COMPILER_INTRINSIC
//func _convertPointerToPointerArgument<
//  FromPointer : _Pointer,
//  ToPointer : _Pointer
//>(_ from: FromPointer) -> ToPointer {
//  return ToPointer(from._rawValue)
//}
//
///// Derive a pointer argument from the address of an inout parameter.
//public // COMPILER_INTRINSIC
//func _convertInOutToPointerArgument<
//  ToPointer : _Pointer
//>(_ from: Builtin.RawPointer) -> ToPointer {
//  return ToPointer(from)
//}
