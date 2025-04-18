import Foundation

public protocol SwtVectorProtocol: SwtMathObjectProtocol {
    associatedtype DataType: SIMD where DataType.Scalar == Scalar

    var _data: DataType { get set }
    init(_ rawData: DataType)
    mutating func set(_ rawData: DataType)
}

public extension SwtVectorProtocol {
    @inlinable
    func hash(into hasher: inout Hasher) {
        self._data.hash(into: &hasher)
    }

    @inlinable
    subscript(index: Int) -> Scalar {
        get {
            return self._data[index]
        }
        set {
            self._data[index] = newValue
        }
    }

    @inlinable
    static func == (lhs: Self, rhs: Self) -> Bool {
        return lhs._data == rhs._data
    }

    @inlinable
    static func != (lhs: Self, rhs: Self) -> Bool {
        return lhs._data != rhs._data
    }

    @inlinable
    mutating func set(_ array: [Scalar]) {
        let count: Int = Swift.min(array.count, self.count)
        for i in 0 ..< count {
            self._data[i] = array[i]
        }
    }

    @inlinable
    mutating func set(_ other: Self) {
        self._data = other._data
    }

    @inlinable
    mutating func set(_ rawData: DataType) {
        self._data = rawData
    }
}

public extension SwtVectorProtocol where Scalar: AdditiveArithmetic {
    mutating func setToIdentity() {
        for i in _data.indices {
            self._data[i] = .zero
        }
    }
}

//--------------------------------------------------------------------------------
// MARK: Accessors Extensions
// Various extension for implementing set and _data accessors for
// Vectors of different size
//--------------------------------------------------------------------------------

public extension SwtVectorProtocol where DataType == SIMD2<Scalar> {
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
        self._data[0] = x
        self._data[1] = y
    }

    @inlinable
    var x: Scalar {
        get { return self._data[0] }
        set { self._data[0] = newValue }
    }

    @inlinable
    var y: Scalar {
        get { return self._data[1] }
        set { self._data[1] = newValue }
    }
}

public extension SwtVectorProtocol where DataType == SIMD3<Scalar> {
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
        self._data[0] = x
        self._data[1] = y
        self._data[2] = z
    }

    @inlinable
    var x: Scalar {
        get { return self._data[0] }
        set { self._data[0] = newValue }
    }

    @inlinable
    var y: Scalar {
        get { return self._data[1] }
        set { self._data[1] = newValue }
    }

    @inlinable
    var z: Scalar {
        get { return self._data[2] }
        set { self._data[2] = newValue }
    }
}

public extension SwtVectorProtocol where DataType == SIMD4<Scalar> {
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
        self._data[0] = x
        self._data[1] = y
        self._data[2] = z
        self._data[3] = w
    }

    @inlinable
    var x: Scalar {
        get { return self._data[0] }
        set { self._data[0] = newValue }
    }

    @inlinable
    var y: Scalar {
        get { return self._data[1] }
        set { self._data[1] = newValue }
    }

    @inlinable
    var z: Scalar {
        get { return self._data[2] }
        set { self._data[2] = newValue }
    }

    @inlinable
    var w: Scalar {
        get { return self._data[3] }
        set { self._data[3] = newValue }
    }
}