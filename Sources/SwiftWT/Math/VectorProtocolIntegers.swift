
public extension SwtVectorProtocol where Scalar: FixedWidthInteger {
    /// Sets all elements in the vector to 0, essentially resetting the vector.
    @inlinable mutating func setToIdentity() {
        for i in indices {
            self._data[i] = 0
        }
    }

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

