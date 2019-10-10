public struct UnsafePointer<Pointee>: _Pointer {

  /// A type that represents the distance between two pointers.
  public typealias Distance = Int

  /// The underlying raw (untyped) pointer.
  public let _rawValue: Builtin.RawPointer

  /// Creates an `UnsafePointer` from a builtin raw pointer.
//  @_transparent
  public init(_ _rawValue: Builtin.RawPointer) {
    self._rawValue = _rawValue
  }

  /// Deallocates the memory block previously allocated at this pointer.
  ///
  /// This pointer must be a pointer to the start of a previously allocated memory
  /// block. The memory must not be initialized or `Pointee` must be a trivial type.
//  @inlinable
  public func deallocate() {
    // Passing zero alignment to the runtime forces "aligned
    // deallocation". Since allocation via `UnsafeMutable[Raw][Buffer]Pointer`
    // always uses the "aligned allocation" path, this ensures that the
    // runtime's allocation and deallocation paths are compatible.
    Builtin.deallocRaw(_rawValue, (-1)._builtinWordValue, (0)._builtinWordValue)
  }

  /// Accesses the instance referenced by this pointer.
  ///
  /// When reading from the `pointee` property, the instance referenced by
  /// this pointer must already be initialized.
  @inlinable // unsafe-performance
  public var pointee: Pointee {
    @_transparent unsafeAddress {
      return self
    }
  }

  /// Executes the given closure while temporarily binding the specified number
  /// of instances to the given type.
  ///
  /// Use this method when you have a pointer to memory bound to one type and
  /// you need to access that memory as instances of another type. Accessing
  /// memory as a type `T` requires that the memory be bound to that type. A
  /// memory location may only be bound to one type at a time, so accessing
  /// the same memory as an unrelated type without first rebinding the memory
  /// is undefined.
  ///
  /// The region of memory starting at this pointer and covering `count`
  /// instances of the pointer's `Pointee` type must be initialized.
  ///
  /// The following example temporarily rebinds the memory of a `UInt64`
  /// pointer to `Int64`, then accesses a property on the signed integer.
  ///
  ///     let uint64Pointer: UnsafePointer<UInt64> = fetchValue()
  ///     let isNegative = uint64Pointer.withMemoryRebound(to: Int64.self) { ptr in
  ///         return ptr.pointee < 0
  ///     }
  ///
  /// Because this pointer's memory is no longer bound to its `Pointee` type
  /// while the `body` closure executes, do not access memory using the
  /// original pointer from within `body`. Instead, use the `body` closure's
  /// pointer argument to access the values in memory as instances of type
  /// `T`.
  ///
  /// After executing `body`, this method rebinds memory back to the original
  /// `Pointee` type.
  ///
  /// - Note: Only use this method to rebind the pointer's memory to a type
  ///   with the same size and stride as the currently bound `Pointee` type.
  ///   To bind a region of memory to a type that is a different size, convert
  ///   the pointer to a raw pointer and use the `bindMemory(to:capacity:)`
  ///   method.
  ///
  /// - Parameters:
  ///   - type: The type to temporarily bind the memory referenced by this
  ///     pointer. The type `T` must be the same size and be layout compatible
  ///     with the pointer's `Pointee` type.
  ///   - count: The number of instances of `Pointee` to bind to `type`.
  ///   - body: A closure that takes a  typed pointer to the
  ///     same memory as this pointer, only bound to type `T`. The closure's
  ///     pointer argument is valid only for the duration of the closure's
  ///     execution. If `body` has a return value, that value is also used as
  ///     the return value for the `withMemoryRebound(to:capacity:_:)` method.
  /// - Returns: The return value, if any, of the `body` closure parameter.
//  @inlinable
//    public func withMemoryRebound<T, Result>(to type: T.Type, capacity count: Int,
//                                             _ body: (UnsafePointer<T>) throws -> Result
//    ) rethrows -> Result {
//        Builtin.bindMemory(_rawValue, count._builtinWordValue, T.self)
//        defer {
//            Builtin.bindMemory(_rawValue, count._builtinWordValue, Pointee.self)
//        }
//        return try body(UnsafePointer<T>(_rawValue))
//    }
//
//  /// Accesses the pointee at the specified offset from this pointer.
//  ///
//  ///
//  /// For a pointer `p`, the memory at `p + i` must be initialized.
//  ///
//  /// - Parameter i: The offset from this pointer at which to access an
//  ///   instance, measured in strides of the pointer's `Pointee` type.
//  @inlinable
//  public subscript(i: Int) -> Pointee {
//    @_transparent
//    unsafeAddress {
//      return self + i
//    }
//  }
//
//  @inlinable // unsafe-performance
//  internal static var _max: UnsafePointer {
//    return UnsafePointer(
    //      bitPattern: 0 as Int &- MemoryLayout<Pointee>.stride
    //    )._unsafelyUnwrappedUnchecked
    //  }
}

public struct UnsafeMutablePointer<Pointee>: _Pointer {
    
    /// A type that represents the distance between two pointers.
    public typealias Distance = Int
    
    /// The underlying raw (untyped) pointer.
    public let _rawValue: Builtin.RawPointer
    
    /// Creates an `UnsafeMutablePointer` from a builtin raw pointer.
    //@_transparent
    public init(_ _rawValue: Builtin.RawPointer) {
        self._rawValue = _rawValue
    }
    /// Creates a mutable typed pointer referencing the same memory as the given
    /// immutable pointer.
    ///
    /// - Parameter other: The immutable pointer to convert.
    @_transparent
    public init(mutating other: UnsafePointer<Pointee>) {
        self._rawValue = other._rawValue
    }
    
    /// Creates a mutable typed pointer referencing the same memory as the given
    /// immutable pointer.
    ///
    /// - Parameter other: The immutable pointer to convert. If `other` is `nil`,
    ///   the result is `nil`.
    @_transparent
    public init?(mutating other: UnsafePointer<Pointee>?) {
        guard let unwrapped = other else { return nil }
        self.init(mutating: unwrapped)
    }
    
    /// Creates an immutable typed pointer referencing the same memory as the
    /// given mutable pointer.
    ///
    /// - Parameter other: The pointer to convert.
    @_transparent
    public init(_ other: UnsafeMutablePointer<Pointee>) {
        self._rawValue = other._rawValue
    }
    
    /// Creates an immutable typed pointer referencing the same memory as the
    /// given mutable pointer.
    ///
    /// - Parameter other: The pointer to convert. If `other` is `nil`, the
    ///   result is `nil`.
    @_transparent
    public init?(_ other: UnsafeMutablePointer<Pointee>?) {
        guard let unwrapped = other else { return nil }
        self.init(unwrapped)
    }
    

    /// Allocates uninitialized memory for the specified number of instances of
    /// type `Pointee`.
    ///
    /// The resulting pointer references a region of memory that is bound to
    /// `Pointee` and is `count * MemoryLayout<Pointee>.stride` bytes in size.
    ///
    /// The following example allocates enough new memory to store four `Int`
    /// instances and then initializes that memory with the elements of a range.
    ///
    ///     let intPointer = UnsafeMutablePointer<Int>.allocate(capacity: 4)
    ///     for i in 0..<4 {
    ///         (intPointer + i).initialize(to: i)
    ///     }
    ///     print(intPointer.pointee)
    ///     // Prints "0"
    ///
    /// When you allocate memory, always remember to deallocate once you're
    /// finished.
    ///
    ///     intPointer.deallocate()
    ///
    /// - Parameter count: The amount of memory to allocate, counted in instances
    ///   of `Pointee`.
//    @inlinable
    public static func allocate(capacity count: Int)
        -> UnsafeMutablePointer<Pointee> {
            let size = MemoryLayout<Pointee>.stride * count
            // For any alignment <= _minAllocationAlignment, force alignment = 0.
            // This forces the runtime's "aligned" allocation path so that
            // deallocation does not require the original alignment.
            //
            // The runtime guarantees:
            //
            // align == 0 || align > _minAllocationAlignment:
            //   Runtime uses "aligned allocation".
            //
            // 0 < align <= _minAllocationAlignment:
            //   Runtime may use either malloc or "aligned allocation".
            let align = Builtin.alignof(Pointee.self)
            //  if Int(align) <= _minAllocationAlignment() {
            //    align = (0)._builtinWordValue
            //  }
            let rawPtr = Builtin.allocRaw(size._builtinWordValue, align)
            Builtin.bindMemory(rawPtr, count._builtinWordValue, Pointee.self)
            return UnsafeMutablePointer(rawPtr)
    }
    
    /// Deallocates the memory block previously allocated at this pointer.
    ///
    /// This pointer must be a pointer to the start of a previously allocated memory
    /// block. The memory must not be initialized or `Pointee` must be a trivial type.
    public func deallocate() {
        // Passing zero alignment to the runtime forces "aligned
        // deallocation". Since allocation via `UnsafeMutable[Raw][Buffer]Pointer`
        // always uses the "aligned allocation" path, this ensures that the
        // runtime's allocation and deallocation paths are compatible.
        Builtin.deallocRaw(_rawValue, (-1)._builtinWordValue, (0)._builtinWordValue)
    }

    /// Accesses the instance referenced by this pointer.
    ///
    /// When reading from the `pointee` property, the instance referenced by this
    /// pointer must already be initialized. When `pointee` is used as the left
    /// side of an assignment, the instance must be initialized or this
    /// pointer's `Pointee` type must be a trivial type.
    ///
    /// Do not assign an instance of a nontrivial type through `pointee` to
    /// uninitialized memory. Instead, use an initializing method, such as
    /// `initialize(to:count:)`.
    /*
    public var pointee: Pointee {
        unsafeAddress {
            return UnsafePointer(self)
        }
        nonmutating unsafeMutableAddress {
            return self
        }
    }
     */
    /// Initializes this pointer's memory with the specified number of
    /// consecutive copies of the given value.
    ///
    /// The destination memory must be uninitialized or the pointer's `Pointee`
    /// must be a trivial type. After a call to `initialize(repeating:count:)`, the
    /// memory referenced by this pointer is initialized.
    ///
    /// - Parameters:
    ///   - repeatedValue: The instance to initialize this pointer's memory with.
    ///   - count: The number of consecutive copies of `newValue` to initialize.
    ///     `count` must not be negative.
    //@inlinable
//    public func initialize(repeating repeatedValue: Pointee, count: Int) {
//        // FIXME: add tests (since the `count` has been added)
//        //  _debugPrecondition(count >= 0,
//        //    "UnsafeMutablePointer.initialize(repeating:count:): negative count")
//        // Must not use `initializeFrom` with a `Collection` as that will introduce
//        // a cycle.
//        for offset in 0..<count {
//            Builtin.initialize(repeatedValue, (self + offset)._rawValue)
//        }
//    }
    
    /// Initializes this pointer's memory with a single instance of the given value.
    ///
    /// The destination memory must be uninitialized or the pointer's `Pointee`
    /// must be a trivial type. After a call to `initialize(to:)`, the
    /// memory referenced by this pointer is initialized. Calling this method is
    /// roughly equivalent to calling `initialize(repeating:count:)` with a
    /// `count` of 1.
    ///
    /// - Parameters:
    ///   - value: The instance to initialize this pointer's pointee to.
    @inlinable
    public func initialize(to value: Pointee) {
        Builtin.initialize(value, self._rawValue)
    }
}
