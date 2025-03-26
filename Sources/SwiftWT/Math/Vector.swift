import Foundation 


public struct Vector<Scalar>: VectorProtocol
where Scalar: SIMDScalar, Scalar: BinaryFloatingPoint
{
    public var _simdData = SIMD3<Scalar>()

    public init() {}

    @inlinable
    public init(_ x: Scalar, _ y: Scalar, _ z: Scalar) {
        self._simdData[0] = x
        self._simdData[1] = y
        self._simdData[2] = z
    }

    @inlinable
    public init(_ other: Vector<Scalar>) {
        self._simdData = other._simdData
    }

    @inlinable
    public init(_ array: [Scalar]) {
        if array.count == 3 {
            self._simdData[0] = array[0]
            self._simdData[1] = array[1]
            self._simdData[2] = array[2]
        }
        else {
            let count: Int = Swift.min(array.count, self.count)
            for i in 0 ..< count {
                self._simdData[i] = array[i]
            }
        }
    }

    @inlinable
    public init(_ rawData: SIMD3<Scalar>) {
        self._simdData = rawData
    }
}


public struct Vector4<Scalar>: VectorProtocol
where Scalar: SIMDScalar, Scalar: BinaryFloatingPoint
{
    public var _simdData = SIMD4<Scalar>()

    public init() {}

    @inlinable
    public init(_ x: Scalar, _ y: Scalar, _ z: Scalar, _ w: Scalar) {
        self._simdData[0] = x
        self._simdData[1] = y
        self._simdData[2] = z
        self._simdData[3] = w
    }

    @inlinable
    public init(_ other: Vector4<Scalar>) {
        self._simdData = other._simdData
    }

    @inlinable
    public init(_ array: [Scalar]) {
        if array.count == 4 {
            self._simdData[0] = array[0]
            self._simdData[1] = array[1]
            self._simdData[2] = array[2]
            self._simdData[3] = array[3]
        }
        else {
            let count: Int = Swift.min(array.count, self.count)
            for i in 0 ..< count {
                self._simdData[i] = array[i]
            }
        }
    }

    @inlinable
    public init(_ rawData: SIMD4<Scalar>) {
        self._simdData = rawData
    }
}