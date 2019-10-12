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
    
    @_transparent
    public init<T>(_ other: UnsafePointer<T>) {
      _rawValue = other._rawValue
    }

    /// Creates a new raw pointer from the given typed pointer.
    ///
    /// Use this initializer to explicitly convert `other` to an `UnsafeRawPointer`
    /// instance. This initializer creates a new pointer to the same address as
    /// `other` and performs no allocation or copying.
    ///
    /// - Parameter other: The typed pointer to convert. If `other` is `nil`, the
    ///   result is `nil`.
    @_transparent
    public init?<T>(_ other: UnsafePointer<T>?) {
      guard let unwrapped = other else { return nil }
      _rawValue = unwrapped._rawValue
    }

    /// Creates a new raw pointer from the given mutable raw pointer.
    ///
    /// Use this initializer to explicitly convert `other` to an `UnsafeRawPointer`
    /// instance. This initializer creates a new pointer to the same address as
    /// `other` and performs no allocation or copying.
    ///
    /// - Parameter other: The mutable raw pointer to convert.
    @_transparent
    public init(_ other: UnsafeMutableRawPointer) {
      _rawValue = other._rawValue
    }

    /// Creates a new raw pointer from the given mutable raw pointer.
    ///
    /// Use this initializer to explicitly convert `other` to an `UnsafeRawPointer`
    /// instance. This initializer creates a new pointer to the same address as
    /// `other` and performs no allocation or copying.
    ///
    /// - Parameter other: The mutable raw pointer to convert. If `other` is
    ///   `nil`, the result is `nil`.
    @_transparent
    public init?(_ other: UnsafeMutableRawPointer?) {
      guard let unwrapped = other else { return nil }
      _rawValue = unwrapped._rawValue
    }

    /// Creates a new raw pointer from the given typed pointer.
    ///
    /// Use this initializer to explicitly convert `other` to an `UnsafeRawPointer`
    /// instance. This initializer creates a new pointer to the same address as
    /// `other` and performs no allocation or copying.
    ///
    /// - Parameter other: The typed pointer to convert.
    @_transparent
    public init<T>(_ other: UnsafeMutablePointer<T>) {
     _rawValue = other._rawValue
    }

    /// Creates a new raw pointer from the given typed pointer.
    ///
    /// Use this initializer to explicitly convert `other` to an `UnsafeRawPointer`
    /// instance. This initializer creates a new pointer to the same address as
    /// `other` and performs no allocation or copying.
    ///
    /// - Parameter other: The typed pointer to convert. If `other` is `nil`, the
    ///   result is `nil`.
    @_transparent
    public init?<T>(_ other: UnsafeMutablePointer<T>?) {
     guard let unwrapped = other else { return nil }
     _rawValue = unwrapped._rawValue
    }

    /// Deallocates the previously allocated memory block referenced by this pointer.
    ///
    /// The memory to be deallocated must be uninitialized or initialized to a
    /// trivial type.
//    @inlinable
    public func deallocate() {
      // Passing zero alignment to the runtime forces "aligned
      // deallocation". Since allocation via `UnsafeMutable[Raw][Buffer]Pointer`
      // always uses the "aligned allocation" path, this ensures that the
      // runtime's allocation and deallocation paths are compatible.
      Builtin.deallocRaw(_rawValue, (-1)._builtinWordValue, (0)._builtinWordValue)
    }

    /// Binds the memory to the specified type and returns a typed pointer to the
    /// bound memory.
    ///
    /// Use the `bindMemory(to:capacity:)` method to bind the memory referenced
    /// by this pointer to the type `T`. The memory must be uninitialized or
    /// initialized to a type that is layout compatible with `T`. If the memory
    /// is uninitialized, it is still uninitialized after being bound to `T`.
    ///
    /// In this example, 100 bytes of raw memory are allocated for the pointer
    /// `bytesPointer`, and then the first four bytes are bound to the `Int8`
    /// type.
    ///
    ///     let count = 4
    ///     let bytesPointer = UnsafeMutableRawPointer.allocate(
    ///             bytes: 100,
    ///             alignedTo: MemoryLayout<Int8>.alignment)
    ///     let int8Pointer = bytesPointer.bindMemory(to: Int8.self, capacity: count)
    ///
    /// After calling `bindMemory(to:capacity:)`, the first four bytes of the
    /// memory referenced by `bytesPointer` are bound to the `Int8` type, though
    /// they remain uninitialized. The remainder of the allocated region is
    /// unbound raw memory. All 100 bytes of memory must eventually be
    /// deallocated.
    ///
    /// - Warning: A memory location may only be bound to one type at a time. The
    ///   behavior of accessing memory as a type unrelated to its bound type is
    ///   undefined.
    ///
    /// - Parameters:
    ///   - type: The type `T` to bind the memory to.
    ///   - count: The amount of memory to bind to type `T`, counted as instances
    ///     of `T`.
    /// - Returns: A typed pointer to the newly bound memory. The memory in this
    ///   region is bound to `T`, but has not been modified in any other way.
    ///   The number of bytes in this region is
    ///   `count * MemoryLayout<T>.stride`.
//    @_transparent
    @discardableResult
    public func bindMemory<T>(
      to type: T.Type, capacity count: Int
    ) -> UnsafePointer<T> {
      Builtin.bindMemory(_rawValue, count._builtinWordValue, type)
      return UnsafePointer<T>(_rawValue)
    }

    /// Returns a typed pointer to the memory referenced by this pointer,
    /// assuming that the memory is already bound to the specified type.
    ///
    /// Use this method when you have a raw pointer to memory that has *already*
    /// been bound to the specified type. The memory starting at this pointer
    /// must be bound to the type `T`. Accessing memory through the returned
    /// pointer is undefined if the memory has not been bound to `T`. To bind
    /// memory to `T`, use `bindMemory(to:capacity:)` instead of this method.
    ///
    /// - Parameter to: The type `T` that the memory has already been bound to.
    /// - Returns: A typed pointer to the same memory as this raw pointer.
    @_transparent
    public func assumingMemoryBound<T>(to: T.Type) -> UnsafePointer<T> {
      return UnsafePointer<T>(_rawValue)
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

    /// Allocates uninitialized memory with the specified size and alignment.
    ///
    /// You are in charge of managing the allocated memory. Be sure to deallocate
    /// any memory that you manually allocate.
    ///
    /// The allocated memory is not bound to any specific type and must be bound
    /// before performing any typed operations. If you are using the memory for
    /// a specific type, allocate memory using the
    /// `UnsafeMutablePointer.allocate(capacity:)` static method instead.
    ///
    /// - Parameters:
    ///   - byteCount: The number of bytes to allocate. `byteCount` must not be negative.
    ///   - alignment: The alignment of the new region of allocated memory, in
    ///     bytes.
    /// - Returns: A pointer to a newly allocated region of memory. The memory is
    ///   allocated, but not initialized.
    public static func allocate(
      byteCount: Int, alignment: Int
    ) -> UnsafeMutableRawPointer {
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
//      var alignment = alignment
//      if alignment <= _minAllocationAlignment() {
//        alignment = 0
//      }
      return UnsafeMutableRawPointer(Builtin.allocRaw(
          byteCount._builtinWordValue, alignment._builtinWordValue))
    }

    /// Deallocates the previously allocated memory block referenced by this pointer.
    ///
    /// The memory to be deallocated must be uninitialized or initialized to a
    /// trivial type.
    public func deallocate() {
      // Passing zero alignment to the runtime forces "aligned
      // deallocation". Since allocation via `UnsafeMutable[Raw][Buffer]Pointer`
      // always uses the "aligned allocation" path, this ensures that the
      // runtime's allocation and deallocation paths are compatible.
      Builtin.deallocRaw(_rawValue, (-1)._builtinWordValue, (0)._builtinWordValue)
    }
    
    /// Binds the memory to the specified type and returns a typed pointer to the
    /// bound memory.
    ///
    /// Use the `bindMemory(to:capacity:)` method to bind the memory referenced
    /// by this pointer to the type `T`. The memory must be uninitialized or
    /// initialized to a type that is layout compatible with `T`. If the memory
    /// is uninitialized, it is still uninitialized after being bound to `T`.
    ///
    /// In this example, 100 bytes of raw memory are allocated for the pointer
    /// `bytesPointer`, and then the first four bytes are bound to the `Int8`
    /// type.
    ///
    ///     let count = 4
    ///     let bytesPointer = UnsafeMutableRawPointer.allocate(
    ///             bytes: 100,
    ///             alignedTo: MemoryLayout<Int8>.alignment)
    ///     let int8Pointer = bytesPointer.bindMemory(to: Int8.self, capacity: count)
    ///
    /// After calling `bindMemory(to:capacity:)`, the first four bytes of the
    /// memory referenced by `bytesPointer` are bound to the `Int8` type, though
    /// they remain uninitialized. The remainder of the allocated region is
    /// unbound raw memory. All 100 bytes of memory must eventually be
    /// deallocated.
    ///
    /// - Warning: A memory location may only be bound to one type at a time. The
    ///   behavior of accessing memory as a type unrelated to its bound type is
    ///   undefined.
    ///
    /// - Parameters:
    ///   - type: The type `T` to bind the memory to.
    ///   - count: The amount of memory to bind to type `T`, counted as instances
    ///     of `T`.
    /// - Returns: A typed pointer to the newly bound memory. The memory in this
    ///   region is bound to `T`, but has not been modified in any other way.
    ///   The number of bytes in this region is
    ///   `count * MemoryLayout<T>.stride`.
    @discardableResult
    public func bindMemory<T>(
      to type: T.Type, capacity count: Int
    ) -> UnsafeMutablePointer<T> {
      Builtin.bindMemory(_rawValue, count._builtinWordValue, type)
      return UnsafeMutablePointer<T>(_rawValue)
    }

    /// Returns a typed pointer to the memory referenced by this pointer,
    /// assuming that the memory is already bound to the specified type.
    ///
    /// Use this method when you have a raw pointer to memory that has *already*
    /// been bound to the specified type. The memory starting at this pointer
    /// must be bound to the type `T`. Accessing memory through the returned
    /// pointer is undefined if the memory has not been bound to `T`. To bind
    /// memory to `T`, use `bindMemory(to:capacity:)` instead of this method.
    ///
    /// - Parameter to: The type `T` that the memory has already been bound to.
    /// - Returns: A typed pointer to the same memory as this raw pointer.
    @_transparent
    public func assumingMemoryBound<T>(to: T.Type) -> UnsafeMutablePointer<T> {
      return UnsafeMutablePointer<T>(_rawValue)
    }

}

public func printPointer(_ ptr: UnsafeMutableRawPointer?) -> UnsafeMutableRawPointer?
{
    return CTopazLib.printPointer(ptr)
}
