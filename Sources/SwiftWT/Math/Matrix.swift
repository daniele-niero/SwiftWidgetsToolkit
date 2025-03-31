

/** 
A generic struct representing a mathematical matrix.
 
The `SwtMatrix` struct conforms to the `SwtMathObjectProtocol`
*/
public struct SwtMatrix<Scalar>: SwtMathObjectProtocol
where Scalar: SIMDScalar, Scalar: BinaryFloatingPoint
{

    @usableFromInline 
    internal var _data: (SIMD4<Scalar>, SIMD4<Scalar>, SIMD4<Scalar>, SIMD4<Scalar>) =
    (
        SIMD4<Scalar>(1.0, 0.0, 0.0, 0.0),
        SIMD4<Scalar>(0.0, 1.0, 0.0, 0.0),
        SIMD4<Scalar>(0.0, 0.0, 1.0, 0.0),
        SIMD4<Scalar>(0.0, 0.0, 0.0, 1.0)
    )

    public var indices: Range<Int> {
        get { return 0 ..< 16 }
    }

    public var count: Int {
        get { return 16 }
    }

    public init() {}

    @inlinable
    public init(_ array: [Scalar]) {
        self.set(array);
    }

    @inlinable
    public init(_ other: SwtMatrix<Scalar>) {
        _data.0 = other._data.0
        _data.1 = other._data.1
        _data.2 = other._data.2
        _data.3 = other._data.3   
    }

    // Init that takes 16 Scalars
    @inlinable 
    public init(_ m00: Scalar, _ m01: Scalar, _ m02: Scalar, _ m03: Scalar,
                _ m10: Scalar, _ m11: Scalar, _ m12: Scalar, _ m13: Scalar,
                _ m20: Scalar, _ m21: Scalar, _ m22: Scalar, _ m23: Scalar,
                _ m30: Scalar, _ m31: Scalar, _ m32: Scalar, _ m33: Scalar) {
        self._data.0[0] = m00
        self._data.0[1] = m01
        self._data.0[2] = m02
        self._data.0[3] = m03

        self._data.1[0] = m10
        self._data.1[1] = m11
        self._data.1[2] = m12
        self._data.1[3] = m13

        self._data.2[0] = m20
        self._data.2[1] = m21
        self._data.2[2] = m22
        self._data.2[3] = m23

        self._data.3[0] = m30
        self._data.3[1] = m31
        self._data.3[2] = m32
        self._data.3[3] = m33
    }

    // Init that takes 4 Vectors
    @inlinable
    public init(_ v0: SwtVector4<Scalar>, _ v1: SwtVector4<Scalar>, _ v2: SwtVector4<Scalar>, _ v3: SwtVector4<Scalar>) {
        self._data.0 = v0._data
        self._data.1 = v1._data
        self._data.2 = v2._data
        self._data.3 = v3._data
    }

    //implement the Decodable protocol
    public init(from decoder: Decoder) throws {
        var container = try decoder.unkeyedContainer()
        self._data.0 = try container.decode(SIMD4<Scalar>.self)
        self._data.1 = try container.decode(SIMD4<Scalar>.self)
        self._data.2 = try container.decode(SIMD4<Scalar>.self)
        self._data.3 = try container.decode(SIMD4<Scalar>.self)
    }

    // implement the Encodable protocol
    public func encode(to encoder: Encoder) throws {
        var container = encoder.unkeyedContainer()
        try container.encode(_data.0)
        try container.encode(_data.1)
        try container.encode(_data.2)
        try container.encode(_data.3)
    }

    // implement the Hashable protocol
    public func hash(into hasher: inout Hasher) {
        hasher.combine(_data.0)
        hasher.combine(_data.1)
        hasher.combine(_data.2)
        hasher.combine(_data.3)
    }

    @inlinable
    public mutating func set(_ array: [Scalar]) {
        if array.count == 16 {
            self._data.0[0] = array[0]
            self._data.0[1] = array[1]
            self._data.0[2] = array[2]
            self._data.0[3] = array[3]

            self._data.1[0] = array[4]
            self._data.1[1] = array[5]
            self._data.1[2] = array[6]
            self._data.1[3] = array[7]

            self._data.2[0] = array[8]
            self._data.2[1] = array[9]
            self._data.2[2] = array[10]
            self._data.2[3] = array[11]

            self._data.3[0] = array[12]
            self._data.3[1] = array[13]
            self._data.3[2] = array[14]
            self._data.3[3] = array[15]
        }
        else {
            let minCount = Swift.min(array.count, self.count)
            for i in 0 ..< minCount {
                if i < 4 {
                    _data.0[i] = array[i]
                }
                else if i < 8 {
                    _data.1[i - 4] = array[i]
                }
                else if i < 12 {
                    _data.2[i - 8] = array[i]
                }
                else if i < 16 {
                    _data.3[i - 12] = array[i]
                }
            }
        }
    }

    public mutating func set(_ other: SwtMatrix<Scalar>) {
        _data.0 = other._data.0
        _data.1 = other._data.1
        _data.2 = other._data.2
        _data.3 = other._data.3
    }

    public mutating func setToIdentity() {
        self._data.0[0] = 0.0
        self._data.0[1] = 0.0
        self._data.0[2] = 0.0
        self._data.0[3] = 1.0

        self._data.1[0] = 0.0
        self._data.1[1] = 0.0
        self._data.1[2] = 0.0
        self._data.1[3] = 1.0

        self._data.2[0] = 0.0
        self._data.2[1] = 0.0
        self._data.2[2] = 0.0
        self._data.2[3] = 1.0

        self._data.3[0] = 0.0
        self._data.3[1] = 0.0
        self._data.3[2] = 0.0
        self._data.3[3] = 1.0
    }

    public subscript(index: Int) -> Scalar {
        get {
            switch index {
                case 0: return _data.0[0]
                case 1: return _data.0[1]
                case 2: return _data.0[2]
                case 3: return _data.0[3]
                case 4: return _data.1[0]
                case 5: return _data.1[1]
                case 6: return _data.1[2]
                case 7: return _data.1[3]
                case 8: return _data.2[0]
                case 9: return _data.2[1]
                case 10: return _data.2[2]
                case 11: return _data.2[3]
                case 12: return _data.3[0]
                case 13: return _data.3[1]
                case 14: return _data.3[2]
                case 15: return _data.3[3]
                default: fatalError("Index out of range")
            }
        }
        set {
            switch index {
                case 0: _data.0[0] = newValue
                case 1: _data.0[1] = newValue
                case 2: _data.0[2] = newValue
                case 3: _data.0[3] = newValue
                case 4: _data.1[0] = newValue
                case 5: _data.1[1] = newValue
                case 6: _data.1[2] = newValue
                case 7: _data.1[3] = newValue
                case 8: _data.2[0] = newValue
                case 9: _data.2[1] = newValue
                case 10: _data.2[2] = newValue
                case 11: _data.2[3] = newValue
                case 12: _data.3[0] = newValue
                case 13: _data.3[1] = newValue
                case 14: _data.3[2] = newValue
                case 15: _data.3[3] = newValue
                default: fatalError("Index out of range")
            }
        }
    }

    /** 
    Subscript that takes a row and column.
    
    - Parameter row: The row of the matrix.
    - Parameter column: The column of the matrix.
    
    - Returns: The value at the given row and column.
    */
    public subscript(row: Int, column: Int) -> Scalar {
        get {
            switch row {
                case 0: return _data.0[column]
                case 1: return _data.1[column]
                case 2: return _data.2[column]
                case 3: return _data.3[column]
                default: fatalError("Index out of range")
            }
        }
        set {
            switch row {
                case 0: _data.0[column] = newValue
                case 1: _data.1[column] = newValue
                case 2: _data.2[column] = newValue
                case 3: _data.3[column] = newValue
                default: fatalError("Index out of range")
            }
        }
    }

    public static func == (lhs: SwtMatrix<Scalar>, rhs: SwtMatrix<Scalar>) -> Bool {
        return lhs._data.0 == rhs._data.0 &&
               lhs._data.1 == rhs._data.1 &&
               lhs._data.2 == rhs._data.2 &&
               lhs._data.3 == rhs._data.3
    }

    public static func * (lhs: SwtMatrix<Scalar>, rhs: SwtMatrix<Scalar>) -> SwtMatrix<Scalar> {
        var result = SwtMatrix<Scalar>()

        for row in 0..<4 {
            for col in 0..<4 {
                var sum: Scalar = 0
                for k in 0..<4 {
                    sum += lhs[row, k] * rhs[k, col]
                }
                result[row, col] = sum
            }
        }

        return result
    }

    /**
     Calculates the inverse of the matrix.
     
     - Returns: The inverse of the matrix.
     */
    public func inverse() -> SwtMatrix<Scalar> {
        var result = SwtMatrix<Scalar>()

        let a0: Scalar = _data.0[0] * _data.1[1] - _data.0[1] * _data.1[0]
        let a1: Scalar = _data.0[0] * _data.1[2] - _data.0[2] * _data.1[0]
        let a2: Scalar = _data.0[0] * _data.1[3] - _data.0[3] * _data.1[0]
        let a3: Scalar = _data.0[1] * _data.1[2] - _data.0[2] * _data.1[1]
        let a4: Scalar = _data.0[1] * _data.1[3] - _data.0[3] * _data.1[1]
        let a5: Scalar = _data.0[2] * _data.1[3] - _data.0[3] * _data.1[2]
        let b0: Scalar = _data.2[0] * _data.3[1] - _data.2[1] * _data.3[0]
        let b1: Scalar = _data.2[0] * _data.3[2] - _data.2[2] * _data.3[0]
        let b2: Scalar = _data.2[0] * _data.3[3] - _data.2[3] * _data.3[0]
        let b3: Scalar = _data.2[1] * _data.3[2] - _data.2[2] * _data.3[1]
        let b4: Scalar = _data.2[1] * _data.3[3] - _data.2[3] * _data.3[1]
        let b5: Scalar = _data.2[2] * _data.3[3] - _data.2[3] * _data.3[2]

        let det1 = a0 * b5
        let det2 = a1 * b4
        let det3 = a2 * b3
        let det4 = a3 * b2
        let det5 = a4 * b1
        let det6 = a5 * b0
        let det = det1 - det2 + det3 + det4 - det5 + det6

        if almostZero(det) {
            return result
        }

        result._data.0[0] =  self._data.1[1] * b5 - self._data.1[2] * b4 + self._data.1[3] * b3
        result._data.1[0] = -self._data.1[0] * b5 + self._data.1[2] * b2 - self._data.1[3] * b1
        result._data.2[0] =  self._data.1[0] * b4 - self._data.1[1] * b2 + self._data.1[3] * b0
        result._data.3[0] = -self._data.1[0] * b3 + self._data.1[1] * b1 - self._data.1[2] * b0
        
        result._data.0[1] = -self._data.0[1] * b5 + self._data.0[2] * b4 - self._data.0[3] * b3
        result._data.1[1] =  self._data.0[0] * b5 - self._data.0[2] * b2 + self._data.0[3] * b1
        result._data.2[1] = -self._data.0[0] * b4 + self._data.0[1] * b2 - self._data.0[3] * b0
        result._data.3[1] =  self._data.0[0] * b3 - self._data.0[1] * b1 + self._data.0[2] * b0
        
        result._data.0[2] =  self._data.3[1] * a5 - self._data.3[2] * a4 + self._data.3[3] * a3
        result._data.1[2] = -self._data.3[0] * a5 + self._data.3[2] * a2 - self._data.3[3] * a1
        result._data.2[2] =  self._data.3[0] * a4 - self._data.3[1] * a2 + self._data.3[3] * a0
        result._data.3[2] = -self._data.3[0] * a3 + self._data.3[1] * a1 - self._data.3[2] * a0
        
        result._data.0[3] = -self._data.2[1] * a5 + self._data.2[2] * a4 - self._data.2[3] * a3
        result._data.1[3] =  self._data.2[0] * a5 - self._data.2[2] * a2 + self._data.2[3] * a1
        result._data.2[3] = -self._data.2[0] * a4 + self._data.2[1] * a2 - self._data.2[3] * a0
        result._data.3[3] =  self._data.2[0] * a3 - self._data.2[1] * a1 + self._data.2[2] * a0

        let invDet = 1.0 / det
        result._data.0 *= invDet
        result._data.1 *= invDet
        result._data.2 *= invDet
        result._data.3 *= invDet

        return result
    } 
}