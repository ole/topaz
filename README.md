# Topaz

An attempt to reimplement a minimal version of the [Swift](https://swift.org) [standard library](https://developer.apple.com/documentation/swift).

## Structure

The files in `Sources/Topaz` contain the Topaz minimal standard library implementation. The public name of this module when importing it in code is "Swift" (not "Topaz") because the compiler looks for certain types inside the module named "Swift".

The CTopazRuntime module is the runtime library used by the Swift module.

## Usage

To use the Topaz standard library in place of the normal Swift standard library, you must pass the `-parse-stdlib` flag when compiling your source code. This tells the compiler to not link with the normal standard library and also removes the automatic implicit `import Swift` statement that the compiler usually inserts into each source file. If you now link with the Topaz library and write `import Swift` explicitly, you can use the Topaz library from your code. You won’t have access to anything defined in the normal Swift standard library.

See the TopazClient executable in this package for an example how to configure a target to use the Topaz library.   

## Background

Swift is known for defining a more-than-usual part of the language inside the standard library. For example, the `Int` and `Bool` types are defined in the standard library and not hardcoded into the compiler. This design aspect of Swift suggests that it should be possible to _replace_ the normal standard library with a different module.

Even though the standard library is separate from the compiler, the compiler does make some assumptions about the existence and names of some types. For example:

* The standard library module must be named "Swift". This name is hardcoded into the compiler. If we used another name, the compiler wouldn’t find types it  such as the literal protocols.
* The compiler assumes that a type named `Bool` exists. Conditional expressions in `if` or `guard` statements must have this type.
* The names of the literal protocols such as `ExpressibleByBooleanLiteral` and `_ExpressibleByBuiltinBooleanLiteral` are hardcoded into the compiler. We must use the same names in order to be able to initialize values with literals such as `true`, `1`, or `"Hello"`.

### The Compilation Process

Normally, the Swift compiler adds an implicit `import Swift` statement at the top of each source file to make the standard library available everywhere. It also automatically links the standard library into every product. Since it’s obviously impossible to import or link the Swift module when building the Swift module itself, the compiler has a special flag, `-parse-stdlib`, that is used to build the standard library itself.

We can use the same flag to build the Topaz library and to build executables that should use the Topaz library and therefore not link against the normal standard library. We do this by passing `.unsafeFlags(["-parse-stdlib"]` to our targets’ `swiftSettings` in `Package.swift`.

### The Builtin Module

Adding the `-parse-stdlib` flag also allows us to import the "Builtin" module. This module provides an interface to the primitive LLVM types and operations the standard library is built on. These map directly to corresponding primitives in [LLVM IR](https://en.wikipedia.org/wiki/LLVM#Intermediate_representation)). For example, the `Int32` type in the standard library is a struct with a single stored property whose type is a Builtin type:

```swift
public struct Int32 {
  public var _value: Builtin.Int32
}
```

Because a Swift struct with a single stored property is a zero-cost abstraction, an `Int32` in Swift has the same memory layout as the underlying LLVM type for 32-bit integers, ensuring efficient code generation.

## FAQ

Q: Why do this?<br>
A: Mostly for fun and for the sake of learning how the Swift compiler and the Swift runtime work.

Q: Does rewriting the Swift standard library have any practical applications?<br>
A: I doubt it. The normal standard library is quite big and has some big dependencies (most notably [ICU](http://site.icu-project.org/home) for Unicode support), so a smaller standard library can be useful for running Swift programs on embedded devices and microcontrollers. But it’s probably a better idea to start with the normal standard library and remove things from it that to start from scratch.

Q: Why the name?<br>
A: A [topaz](https://en.wikipedia.org/wiki/Topaz_(hummingbird)) is a type of hummingbird, and hummingbirds are [closely related](https://en.wikipedia.org/wiki/Apodiformes) to [swifts](https://en.wikipedia.org/wiki/Swift).

Q: Why don’t we import Darwin or Glibc directly inside Topaz to get access to OS APIs (e.g. print to stdout)?<br>
A: Because the Clang importer inside the Swift compiler expects a lot of Swift types to exist in the Swift module. It needs those types to map C APIs to Swift. We don’t have all of these types yet, so we want to start by exposing our own C APIs that only use types we have.
