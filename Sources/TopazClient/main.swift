import Swift // Imports Topaz, not the normal standard library.

let a = true
var b: Bool

if a {
  b = false
} else {
  b = true
}

let n = 42
printInt(n)

printBool(false)

func foo<T>(_ a: T) -> (T, T) {
    let b = a
    let c = a
    return (b, c)
}

let u8: UInt8 = 1
_ = foo(u8)
let z = foo(23)
printInt(z.0)
printInt(z.1)

struct A {
    var a: Int
    var b: Int
}

let s = A(a: 1, b: 2)
let t = foo(s)

printInt(t.0.a)
printInt(t.0.b)
printInt(t.1.a)
printInt(t.1.b)

let v = 3.1415926
let d = foo(v)
printDouble(d.0)
printDouble(d.1)
