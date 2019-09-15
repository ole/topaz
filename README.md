# Topaz

An attempt to reimplement a minimal version of the Swift standard library.

## Structure

The files in `Sources/Topaz` contain the Topaz minimal standard library implementation. The public name of this module when importing it in code is "Swift" (not "Topaz") because the compiler looks for certain types inside the module named "Swift".

The CTopazRuntime module is the runtime library used by the Swift module.

## Usage

To use the Topaz standard library in place of the normal Swift standard library, you must pass the `-parse-stdlib` flag when compiling your source code. This tells the compiler to not link with the normal standard library and also removes the automatic implicit `import Swift` statement that the compiler usually inserts into each source file. If you now link with the Topaz library and write `import Swift` explicitly, you can use the Topaz library from your code. You won’t have access to anything defined in the normal Swift standard library.

See the TopazClient executable in this package for an example how to configure a target to use the Topaz library.   

## FAQ

Q: Why the name?<br>
A: A [topaz](https://en.wikipedia.org/wiki/Topaz_(hummingbird)) is a type of hummingbird, and hummingbirds are [closely related](https://en.wikipedia.org/wiki/Apodiformes) to [swifts](https://en.wikipedia.org/wiki/Swift).

Q: Why don’t we import Darwin or Glibc directly inside Topaz to get access to OS APIs (e.g. print to stdout)?<br>
A: Because the Clang importer inside the Swift compiler expects a lot of Swift types to exist in the Swift module. It needs those types to map C APIs to Swift. We don’t have all of these types yet, so we want to start by exposing our own C APIs that only use types we have.
