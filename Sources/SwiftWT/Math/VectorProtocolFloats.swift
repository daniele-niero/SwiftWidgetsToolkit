import Foundation

public extension SwtVectorProtocol where Scalar: BinaryFloatingPoint {
    @inlinable
    mutating func setToIdentity() {
        for i in _data.indices {
            self._data[i] = 0.0
        }
    }

    func lerp(with other: Self, lerpFactor: Scalar) -> Self {
        var data = other._data - self._data
        data *= clamped(lerpFactor, from: 0.0, to: 1.0)
        data += self._data
        return Self(data)
    }

    mutating func lerped(with other: Self, lerpFactor: Scalar) {
        var data = other._data - self._data
        data *= clamped(lerpFactor, from: 0.0, to: 1.0)
        self._data += data
    }

    @inlinable static prefix func - (lhs: Self) -> Self {
        return Self(-lhs._data)
    }

    // MARK: Arithmetic Operations

    @inlinable static func + (lhs: Self, rhs: Self) -> Self {
        return Self(lhs._data + rhs._data)
    }

    @inlinable static func + (lhs: Self, rhs: Self.Scalar) -> Self {
        return Self(lhs._data + rhs)
    }

    @inlinable static func - (lhs: Self, rhs: Self) -> Self {
        return Self(lhs._data - rhs._data)
    }

    @inlinable static func - (lhs: Self, rhs: Self.Scalar) -> Self {
        return Self(lhs._data - rhs)
    }

    @inlinable static func * (lhs: Self, rhs: Self) -> Self {
        return Self(lhs._data * rhs._data)
    }

    @inlinable static func * (lhs: Self, rhs: Self.Scalar) -> Self {
        return Self(lhs._data * rhs)
    }

    @inlinable static func / (lhs: Self, rhs: Self) -> Self {
        return Self(lhs._data / rhs._data)
    }

    @inlinable static func / (lhs: Self, rhs: Self.Scalar) -> Self {
        return Self(lhs._data / rhs)
    }

    // MARK: Arithmetic Updates

    @inlinable static func += (lhs: inout Self, rhs: Self) {
        lhs._data += rhs._data
    }

    @inlinable static func += (lhs: inout Self, rhs: Self.Scalar) {
        lhs._data += rhs
    }

    @inlinable static func -= (lhs: inout Self, rhs: Self) {
        lhs._data -= rhs._data
    }

    @inlinable static func -= (lhs: inout Self, rhs: Self.Scalar) {
        lhs._data -= rhs
    }

    @inlinable static func *= (lhs: inout Self, rhs: Self) {
        lhs._data *= rhs._data
    }

    @inlinable static func *= (lhs: inout Self, rhs: Self.Scalar) {
        lhs._data *= rhs
    }

    @inlinable static func /= (lhs: inout Self, rhs: Self) {
        lhs._data /= rhs._data
    }

    @inlinable static func /= (lhs: inout Self, rhs: Self.Scalar) {
        lhs._data /= rhs
    }

    // MARK: Common Operations

    @inlinable
    func inverse() -> Self {
        return Self(self._data * -1.0)
    }

    @inlinable
    mutating func inversed() {
        self._data *= -1.0
    }

    @inlinable
    func squaredLength() -> Scalar {
        return (self._data * self._data).sum()
    }

    func length() -> Scalar {
        return self.squaredLength().squareRoot()
    }

    func normScaleFactor() throws -> Scalar {
        let len = self.length()
        let tol: Scalar = 1e-9
        if almostZero(len, tol: tol) {
            throw SwtMathErrors.LengthIsZero("Cannot normalize a Vector if its length is zero")
        }
        return 1.0 / len
    }

    func normalize() throws -> Self {
        let scaleFactor = try self.normScaleFactor()
        return self * scaleFactor
    }

    mutating func normalized() throws {
        let scaleFactor = try self.normScaleFactor()
        self._data *= scaleFactor
    }

    func cross(_ other: Self) -> Self {
        var result = DataType()

        var next_i: Int
        var next_next_i: Int
        for i in self._data.indices {
            next_i = (i + 1) % self._data.scalarCount
            next_next_i = (i + 2) % self._data.scalarCount

            result[i] = self[next_i] * other[next_next_i] - self[next_next_i] * other[next_i]
        }

        return Self(result)
    }

    mutating func crossed(_ other: Self) {
        var result = DataType()

        var next_i: Int
        var next_next_i: Int
        for i in self.indices {
            next_i = (i + 1) % self._data.scalarCount
            next_next_i = (i + 2) % self._data.scalarCount

            result[i] = self[next_i] * other[next_next_i] - self[next_next_i] * other[next_i]
        }

        self.set(result)
    }

    @inlinable
    func dot(_ other: Self) -> Scalar {
        return (self._data * other._data).sum()
    }

    func squaredDistance(to other: Self) -> Scalar {
        return (self - other).squaredLength()
    }

    func distance(to other: Self) -> Scalar {
        return squaredDistance(to: other).squareRoot()
    }

    func angle(with other: Self) -> Scalar {
        let dot = self.dot(other)

        if dot < -1.0 {
            return Scalar.pi
        } else if dot > 1.0 {
            return 0.0
        } else {
            return acos(dot as! Double) as! Scalar
        }
    }

    func reflect(normal: Self) -> Self {
        let dot = self.dot(normal)
        return ( normal * (2.0 * dot) ) - self
    }

    func refract(normal: Self, eta: Scalar) -> Self {
        let dot = self.dot(normal)
        let k = 1.0 - eta*eta*(1.0 - dot*dot)

        var result = Self()
        if k >= Scalar.ulpOfOne {
            result = self * eta
            result -= normal * (eta*dot + k.squareRoot())
        }
        return result
    }
}