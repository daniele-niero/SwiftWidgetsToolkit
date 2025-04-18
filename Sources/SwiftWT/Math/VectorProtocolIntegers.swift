
public extension SwtVectorProtocol where Scalar: FixedWidthInteger {
    @inlinable static prefix func - (lhs: Self) -> Self where Scalar: SignedInteger {
        var result = Self()
        for i in lhs.indices {
            result[i] = -lhs._data[i]
        }
        return result
    }

    // MARK: Arithmetic Operations

    @inlinable static func + (lhs: Self, rhs: Self) -> Self {
        return Self(lhs._data &+ rhs._data)
    }

    @inlinable static func - (lhs: Self, rhs: Self) -> Self {
        return Self(lhs._data &- rhs._data)
    }

    @inlinable static func * (lhs: Self, rhs: Self) -> Self {
        return Self(lhs._data &* rhs._data)
    }

    @inlinable static func / (lhs: Self, rhs: Self) -> Self {
        return Self(lhs._data / rhs._data)
    }

    // MARK: Arithmetic Updates

    @inlinable static func += (lhs: inout Self, rhs: Self) {
        lhs._data &+= rhs._data
    }

    @inlinable static func -= (lhs: inout Self, rhs: Self) {
        lhs._data &-= rhs._data
    }

    @inlinable static func *= (lhs: inout Self, rhs: Self) {
        lhs._data &*= rhs._data
    }

    @inlinable static func /= (lhs: inout Self, rhs: Self) {
        lhs._data /= rhs._data
    }
}

