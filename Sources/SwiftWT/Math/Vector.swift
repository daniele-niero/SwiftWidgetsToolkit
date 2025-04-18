import Foundation


public struct SwtVector2<Scalar>: SwtVectorProtocol
where Scalar: SIMDScalar & AdditiveArithmetic
{
    public var _data = SIMD2<Scalar>()

    public init() {}

    @inlinable
    public init(_ x: Scalar, _ y: Scalar) {
        self._data[0] = x
        self._data[1] = y
    }

    @inlinable
    public init(_ other: SwtVector2<Scalar>) {
        self._data = other._data
    }

    @inlinable
    public init(_ array: [Scalar]) {
        if array.count == 2 {
            self._data[0] = array[0]
            self._data[1] = array[1]
        }
        else {
            let count: Int = Swift.min(array.count, self.count)
            for i in 0 ..< count {
                self._data[i] = array[i]
            }
        }
    }

    @inlinable
    public init(_ rawData: SIMD2<Scalar>) {
        self._data = rawData
    }
}


public struct SwtVector3<Scalar>: SwtVectorProtocol
where Scalar: SIMDScalar & AdditiveArithmetic
{
    public var _data = SIMD3<Scalar>()

    public init() {}

    @inlinable
    public init(_ x: Scalar, _ y: Scalar, _ z: Scalar) {
        self._data[0] = x
        self._data[1] = y
        self._data[2] = z
    }

    @inlinable
    public init(_ other: SwtVector3<Scalar>) {
        self._data = other._data
    }

    @inlinable
    public init(_ array: [Scalar]) {
        if array.count == 3 {
            self._data[0] = array[0]
            self._data[1] = array[1]
            self._data[2] = array[2]
        }
        else {
            let count: Int = Swift.min(array.count, self.count)
            for i in 0 ..< count {
                self._data[i] = array[i]
            }
        }
    }

    @inlinable
    public init(_ rawData: SIMD3<Scalar>) {
        self._data = rawData
    }
}


public struct SwtVector4<Scalar>: SwtVectorProtocol
where Scalar: SIMDScalar & AdditiveArithmetic
{
    public var _data = SIMD4<Scalar>()

    public init() {}

    @inlinable
    public init(_ x: Scalar, _ y: Scalar, _ z: Scalar, _ w: Scalar) {
        self._data[0] = x
        self._data[1] = y
        self._data[2] = z
        self._data[3] = w
    }

    @inlinable
    public init(_ other: SwtVector4<Scalar>) {
        self._data = other._data
    }

    @inlinable
    public init(_ array: [Scalar]) {
        if array.count == 4 {
            self._data[0] = array[0]
            self._data[1] = array[1]
            self._data[2] = array[2]
            self._data[3] = array[3]
        }
        else {
            let count: Int = Swift.min(array.count, self.count)
            for i in 0 ..< count {
                self._data[i] = array[i]
            }
        }
    }

    @inlinable
    public init(_ rawData: SIMD4<Scalar>) {
        self._data = rawData
    }
}