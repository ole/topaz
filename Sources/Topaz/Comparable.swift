public protocol Comparable : Equatable {
    static func < (lhs: Self, rhs: Self) -> Bool
    
    static func <= (lhs: Self, rhs: Self) -> Bool
    
    static func >= (lhs: Self, rhs: Self) -> Bool
    
    static func > (lhs: Self, rhs: Self) -> Bool
}

extension Comparable {
    @inlinable
    public static func > (lhs: Self, rhs: Self) -> Bool {
        return rhs < lhs
    }
    
    @inlinable
    public static func <= (lhs: Self, rhs: Self) -> Bool {
        return !(rhs < lhs)
    }
    
    @inlinable
    public static func >= (lhs: Self, rhs: Self) -> Bool {
        return !(lhs < rhs)
    }
}
