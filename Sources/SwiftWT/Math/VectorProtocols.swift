import Foundation

public protocol VectorProtocol: MathObjectProtocol {
    associatedtype DataType: SIMD where DataType.Scalar == Scalar

    var _simdData: DataType { get set }

    init(_ rawData: DataType)

    mutating func set(_ rawData: DataType)
}


public extension VectorProtocol {
    @inlinable
    func hash(into hasher: inout Hasher) {
        self._simdData.hash(into: &hasher)
    }

    @inlinable
    subscript(index: Int) -> Scalar {
        get {
            return self._simdData[index]
        }
        set {
            self._simdData[index] = newValue
        }
    }

    @inlinable
    static func == (lhs: Self, rhs: Self) -> Bool {
        return lhs._simdData == rhs._simdData
    }

    @inlinable
    static func != (lhs: Self, rhs: Self) -> Bool {
        return lhs._simdData != rhs._simdData
    }

    @inlinable
    mutating func set(_ array: [Scalar]) {
        let count: Int = Swift.min(array.count, self.count)
        for i in 0 ..< count {
            self._simdData[i] = array[i]
        }
    }

    @inlinable
    mutating func set(_ other: Self) {
        self._simdData = other._simdData
    }

    @inlinable
    mutating func set(_ rawData: DataType) {
        self._simdData = rawData
    }
}

/*------ Various extension for implementing set and _simdData accessors for Vectors of different size ------*/

public extension VectorProtocol where DataType == SIMD2<Scalar> {
    @inlinable
    var indices: Range<Int> {
        get { return 0..<2 }
    }

    @inlinable
    var count: Int {
        get { return 2 }
    }

    @inlinable
    mutating func set(_ x: Scalar, _ y: Scalar) {
        self._simdData[0] = x
        self._simdData[1] = y
    }

    @inlinable
    var x: Scalar {
        get { return self._simdData[0] }
        set { self._simdData[0] = newValue }
    }

    @inlinable
    var y: Scalar {
        get { return self._simdData[1] }
        set { self._simdData[1] = newValue }
    }
}

public extension VectorProtocol where DataType == SIMD3<Scalar> {
    @inlinable
    var indices: Range<Int> {
        get { return 0..<3 }
    }

    @inlinable
    var count: Int {
        get { return 3 }
    }

    @inlinable
    mutating func set(_ x: Scalar, _ y: Scalar, _ z: Scalar) {
        self._simdData[0] = x
        self._simdData[1] = y
        self._simdData[2] = z
    }

    @inlinable
    var x: Scalar {
        get { return self._simdData[0] }
        set { self._simdData[0] = newValue }
    }

    @inlinable
    var y: Scalar {
        get { return self._simdData[1] }
        set { self._simdData[1] = newValue }
    }

    @inlinable
    var z: Scalar {
        get { return self._simdData[2] }
        set { self._simdData[2] = newValue }
    }
}

public extension VectorProtocol where DataType == SIMD4<Scalar> {
    @inlinable
    var indices: Range<Int> {
        get { return 0..<4 }
    }

    @inlinable
    var count: Int {
        get { return 4 }
    }

    @inlinable
    mutating func set(_ x: Scalar, _ y: Scalar, _ z: Scalar, _ w: Scalar) {
        self._simdData[0] = x
        self._simdData[1] = y
        self._simdData[2] = z
        self._simdData[3] = w
    }

    @inlinable
    var x: Scalar {
        get { return self._simdData[0] }
        set { self._simdData[0] = newValue }
    }

    @inlinable
    var y: Scalar {
        get { return self._simdData[1] }
        set { self._simdData[1] = newValue }
    }

    @inlinable
    var z: Scalar {
        get { return self._simdData[2] }
        set { self._simdData[2] = newValue }
    }

    @inlinable
    var w: Scalar {
        get { return self._simdData[3] }
        set { self._simdData[3] = newValue }
    }
}


/*------ Extensions for basic arithmetics operations ------*/

public extension VectorProtocol where Scalar: BinaryFloatingPoint {
    @inlinable
    mutating func setToIdentity() {
        for i in indices {
            self._simdData[i] = 0.0
        }
    }

    func lerp(with other: Self, lerpFactor: Scalar) -> Self {
        var data = other._simdData - self._simdData
        data *= clamped(lerpFactor, from: 0.0, to: 1.0)
        data += self._simdData
        return Self(data)
    }

    mutating func lerped(with other: Self, lerpFactor: Scalar) {
        var data = other._simdData - self._simdData
        data *= clamped(lerpFactor, from: 0.0, to: 1.0)
        self._simdData += data
    }

    @inlinable static prefix func - (lhs: Self) -> Self {
        return Self(-lhs._simdData)
    }

    /*------ Arithmetic operations ------*/

    @inlinable static func + (lhs: Self, rhs: Self) -> Self {
        return Self(lhs._simdData + rhs._simdData)
    }

    @inlinable static func + (lhs: Self, rhs: Self.Scalar) -> Self {
        return Self(lhs._simdData + rhs)
    }

    @inlinable static func - (lhs: Self, rhs: Self) -> Self {
        return Self(lhs._simdData - rhs._simdData)
    }

    @inlinable static func - (lhs: Self, rhs: Self.Scalar) -> Self {
        return Self(lhs._simdData - rhs)
    }

    @inlinable static func * (lhs: Self, rhs: Self) -> Self {
        return Self(lhs._simdData * rhs._simdData)
    }

    @inlinable static func * (lhs: Self, rhs: Self.Scalar) -> Self {
        return Self(lhs._simdData * rhs)
    }

    @inlinable static func / (lhs: Self, rhs: Self) -> Self {
        return Self(lhs._simdData / rhs._simdData)
    }

    @inlinable static func / (lhs: Self, rhs: Self.Scalar) -> Self {
        return Self(lhs._simdData / rhs)
    }

    /*------ Arithmetic updates ------*/

    @inlinable static func += (lhs: inout Self, rhs: Self) {
        lhs._simdData += rhs._simdData
    }

    @inlinable static func += (lhs: inout Self, rhs: Self.Scalar) {
        lhs._simdData += rhs
    }

    @inlinable static func -= (lhs: inout Self, rhs: Self) {
        lhs._simdData -= rhs._simdData
    }

    @inlinable static func -= (lhs: inout Self, rhs: Self.Scalar) {
        lhs._simdData -= rhs
    }

    @inlinable static func *= (lhs: inout Self, rhs: Self) {
        lhs._simdData *= rhs._simdData
    }

    @inlinable static func *= (lhs: inout Self, rhs: Self.Scalar) {
        lhs._simdData *= rhs
    }

    @inlinable static func /= (lhs: inout Self, rhs: Self) {
        lhs._simdData /= rhs._simdData
    }

    @inlinable static func /= (lhs: inout Self, rhs: Self.Scalar) {
        lhs._simdData /= rhs
    }
}

public extension VectorProtocol where Scalar: FixedWidthInteger {

    /// Sets all elements in the vector to 0, essentially resetting the vector.
    /// This can be used to set the vector to an "identity" state for many operations.
    @inlinable
    mutating func setToIdentity() {
        for i in indices {
            self._simdData[i] = 0
        }
    }

    // MARK: - Safe Arithmetic (Overflow Checking)

    /// Adds two vectors element-wise. Handles overflow by clamping to `Scalar.max`.
    @inlinable
    static func + (lhs: Self, rhs: Self) -> Self {
        var result = lhs
        for i in lhs.indices {
            let (sum, overflow) = lhs._simdData[i].addingReportingOverflow(rhs._simdData[i])
            result._simdData[i] = overflow ? Scalar.max : sum  // Handle overflow by clamping to max
        }
        return result
    }

    /// Subtracts two vectors element-wise. Handles overflow by clamping to `Scalar.min`.
    @inlinable
    static func - (lhs: Self, rhs: Self) -> Self {
        var result = lhs
        for i in lhs.indices {
            let (difference, overflow) = lhs._simdData[i].subtractingReportingOverflow(rhs._simdData[i])
            result._simdData[i] = overflow ? Scalar.min : difference  // Handle overflow by clamping to min
        }
        return result
    }

    /// Multiplies two vectors element-wise. Handles overflow by clamping to `Scalar.max`.
    @inlinable
    static func * (lhs: Self, rhs: Self) -> Self {
        var result = lhs
        for i in lhs.indices {
            let (product, overflow) = lhs._simdData[i].multipliedReportingOverflow(by: rhs._simdData[i])
            result._simdData[i] = overflow ? Scalar.max : product  // Handle overflow by clamping to max
        }
        return result
    }

    /// Divides two vectors element-wise. Handles division by zero and clamping to `Scalar.max` in case of overflow.
    @inlinable
    static func / (lhs: Self, rhs: Self) -> Self {
        var result = lhs
        for i in lhs.indices {
            // Prevent division by zero
            guard rhs._simdData[i] != 0 else {
                result._simdData[i] = Scalar.max
                continue
            }
            result._simdData[i] = lhs._simdData[i] / rhs._simdData[i]
        }
        return result
    }

    // MARK: - Fast Arithmetic (Overflow Wrapping)

    /// Adds two vectors element-wise with wrapping (no overflow checks).
    @inlinable
    static func &+ (lhs: Self, rhs: Self) -> Self {
        var result = lhs
        for i in lhs.indices {
            result._simdData[i] = lhs._simdData[i] &+ rhs._simdData[i]  // Wraps on overflow
        }
        return result
    }

    /// Subtracts two vectors element-wise with wrapping (no overflow checks).
    @inlinable
    static func &- (lhs: Self, rhs: Self) -> Self {
        var result = lhs
        for i in lhs.indices {
            result._simdData[i] = lhs._simdData[i] &- rhs._simdData[i]  // Wraps on overflow
        }
        return result
    }

    /// Multiplies two vectors element-wise with wrapping (no overflow checks).
    @inlinable
    static func &* (lhs: Self, rhs: Self) -> Self {
        var result = lhs
        for i in lhs.indices {
            result._simdData[i] = lhs._simdData[i] &* rhs._simdData[i]  // Wraps on overflow
        }
        return result
    }

    /// Divides two vectors element-wise with wrapping (no overflow checks).
    @inlinable
    static func &/ (lhs: Self, rhs: Self) -> Self {
        var result = lhs
        for i in lhs.indices {
            // Prevent division by zero by wrapping to Scalar.max
            guard rhs._simdData[i] != 0 else {
                result._simdData[i] = Scalar.max
                continue
            }
            result._simdData[i] = lhs._simdData[i] &/ rhs._simdData[i]  // Wraps on overflow
        }
        return result
    }

    // MARK: - Arithmetic Updates (For Both Safe and Fast)

    /// Adds another vector to this vector element-wise with overflow checking.
    @inlinable
    static func += (lhs: inout Self, rhs: Self) {
        for i in lhs.indices {
            let (sum, overflow) = lhs._simdData[i].addingReportingOverflow(rhs._simdData[i])
            lhs._simdData[i] = overflow ? Scalar.max : sum  // Handle overflow by clamping to max
        }
    }

    /// Subtracts another vector from this vector element-wise with overflow checking.
    @inlinable
    static func -= (lhs: inout Self, rhs: Self) {
        for i in lhs.indices {
            let (difference, overflow) = lhs._simdData[i].subtractingReportingOverflow(rhs._simdData[i])
            lhs._simdData[i] = overflow ? Scalar.min : difference  // Handle overflow by clamping to min
        }
    }

    /// Multiplies this vector by another vector element-wise with overflow checking.
    @inlinable
    static func *= (lhs: inout Self, rhs: Self) {
        for i in lhs.indices {
            let (product, overflow) = lhs._simdData[i].multipliedReportingOverflow(by: rhs._simdData[i])
            lhs._simdData[i] = overflow ? Scalar.max : product  // Handle overflow by clamping to max
        }
    }

    /// Divides this vector by another vector element-wise with overflow checking.
    @inlinable
    static func /= (lhs: inout Self, rhs: Self) {
        for i in lhs.indices {
            // Prevent division by zero
            guard rhs._simdData[i] != 0 else {
                lhs._simdData[i] = Scalar.max
                continue
            }
            lhs._simdData[i] = lhs._simdData[i] / rhs._simdData[i]
        }
    }

    // MARK: - Fast Arithmetic Updates (For Wrapping)

    /// Adds another vector to this vector element-wise with overflow wrapping.
    @inlinable
    static func &+= (lhs: inout Self, rhs: Self) {
        for i in lhs.indices {
            lhs._simdData[i] = lhs._simdData[i] &+ rhs._simdData[i]  // Wraps on overflow
        }
    }

    /// Subtracts another vector from this vector element-wise with overflow wrapping.
    @inlinable
    static func &-= (lhs: inout Self, rhs: Self) {
        for i in lhs.indices {
            lhs._simdData[i] = lhs._simdData[i] &- rhs._simdData[i]  // Wraps on overflow
        }
    }

    /// Multiplies this vector by another vector element-wise with overflow wrapping.
    @inlinable
    static func &*= (lhs: inout Self, rhs: Self) {
        for i in lhs.indices {
            lhs._simdData[i] = lhs._simdData[i] &* rhs._simdData[i]  // Wraps on overflow
        }
    }

    /// Divides this vector by another vector element-wise with overflow wrapping.
    @inlinable
    static func &/= (lhs: inout Self, rhs: Self) {
        for i in lhs.indices {
            // Prevent division by zero by wrapping to Scalar.max
            guard rhs._simdData[i] != 0 else {
                lhs._simdData[i] = Scalar.max
                continue
            }
            lhs._simdData[i] = lhs._simdData[i] &/ rhs._simdData[i]  // Wraps on overflow
        }
    }
}



 /*------ extensions for other common operations ------*/

public extension VectorProtocol
where Scalar: BinaryFloatingPoint
{
    @inlinable
    func inverse() -> Self {
        return Self(self._simdData * -1.0)
    }

    @inlinable
    mutating func inversed() {
        self._simdData *= -1.0
    }

    @inlinable
    func squaredLength() -> Scalar {
        return (self._simdData * self._simdData).sum()
    }

    func length() -> Scalar {
        return self.squaredLength().squareRoot()
    }

    func normScaleFactor() throws -> Scalar {
        let len = self.length()
        let tol: Scalar = 1e-9
        if almostZero(len, tol: tol) {
            throw NMathErrors.LengthIsZero("Cannot normalize a Vector if its length is zero")
        }
        return 1.0 / len
    }

    func normalize() throws -> Self {
        let scaleFactor = try self.normScaleFactor()
        return self * scaleFactor
    }

    mutating func normalized() throws {
        let scaleFactor = try self.normScaleFactor()
        self._simdData *= scaleFactor
    }

    func cross(_ other: Self) -> Self {
        var result = DataType()

        var next_i: Int
        var next_next_i: Int
        for i in self._simdData.indices {
            next_i = (i + 1) % self._simdData.scalarCount
            next_next_i = (i + 2) % self._simdData.scalarCount

            result[i] = self[next_i] * other[next_next_i] - self[next_next_i] * other[next_i]
        }

        return Self(result)
    }

    mutating func crossed(_ other: Self) {
        var result = DataType()

        var next_i: Int
        var next_next_i: Int
        for i in self.indices {
            next_i = (i + 1) % self._simdData.scalarCount
            next_next_i = (i + 2) % self._simdData.scalarCount

            result[i] = self[next_i] * other[next_next_i] - self[next_next_i] * other[next_i]
        }

        self.set(result)
    }

    @inlinable
    func dot(_ other: Self) -> Scalar {
        return (self._simdData * other._simdData).sum()
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