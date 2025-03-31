
// struct SwtMatrixData4<Scalar: SIMDScalar>: Collection {
//     private var storage: (SwtVector4<Scalar>, SwtVector4<Scalar>, SwtVector4<Scalar>, SwtVector4<Scalar>)
    
//     init(_ e0: SwtVector4<Scalar>, _ e1: SwtVector4<Scalar>, _ e2: SwtVector4<Scalar>, _ e3: SwtVector4<Scalar>) {
//         self.storage = (e0, e1, e2, e3)
//     }
    
//     // Conform to Collection:
//     typealias Index = Int
//     typealias Element = SwtVector4<Scalar>
    
//     var startIndex: Int { 0 }
//     var endIndex: Int { 4 }
    
//     func index(after i: Int) -> Int {
//         precondition(i < endIndex, "Index out of bounds")
//         return i + 1
//     }
    
//     subscript(index: Int) -> SwtVector4<Scalar> {
//         get {
//             precondition(index >= 0 && index < 4, "Index out of bounds")
//             switch index {
//             case 0: return storage.0
//             case 1: return storage.1
//             case 2: return storage.2
//             case 3: return storage.3
//             default:
//                 fatalError("Index out of bounds")
//             }
//         }
//         set {
//             precondition(index >= 0 && index < 4, "Index out of bounds")
//             switch index {
//             case 0: storage.0 = newValue
//             case 1: storage.1 = newValue
//             case 2: storage.2 = newValue
//             case 3: storage.3 = newValue
//             default:
//                 fatalError("Index out of bounds")
//             }
//         }
//     }
// }


public protocol SwtMatrixProtocol: SwtMathObjectProtocol {
    associatedtype VectorType: SIMD where VectorType.Scalar == Scalar
    associatedtype DataType: Collection where DataType.Element == VectorType
    
    var _data: DataType { get set }
    init(_ rawData: DataType)
    mutating func set(_ rawData: DataType)
}

// public extension SwtMatrixProtocol 
// where VectorType == SIMD4<Scalar>,
//       DataType: [VectorType, VectorType, VectorType, VectorType] 
// {
//     @inlinable
//     var indices: Range<Int> {return 0..<16}

//     @inlinable
//     var count: Int {return 16}
// }