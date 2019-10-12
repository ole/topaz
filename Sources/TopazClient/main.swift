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

let optional = Optional<Bool>.some(true)

if let b = optional {
    printBool(b)
}

protocol P {
    var value: Int { get set }
    init(_ a: Int)
}

//extension P {
//    init?(_ a: Int) {
//        if a == 0 {
//            return nil
//        }
//
//        self.init(a)
//    }
//}

struct Bla {
    var value: Int
    init?() {
        return nil
    }
}

struct B : P {
    var value: Int
    init(_ a: Int) {
        value = a
    }
}

let bb: Bla? = Bla()

let p = printPointer(UnsafeMutableRawPointer(bitPattern: 0x123456))
_ = printPointer(p)

var i = 1
var intPointer = UnsafeMutableRawPointer.allocate(byteCount: 8, alignment: 0)
_ = printPointer(intPointer)

var ptr = UnsafeMutablePointer(&i)
_ = printPointer(UnsafeMutableRawPointer(ptr))

ptr.pointee = 2
printInt(i)
