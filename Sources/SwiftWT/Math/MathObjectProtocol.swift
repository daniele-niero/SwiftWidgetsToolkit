public protocol SwtMathObjectProtocol: CustomStringConvertible, Sequence, Decodable, Encodable, Hashable {
    associatedtype Scalar: SIMDScalar

    var indices: Range<Int> { get }
    var count: Int { get }

    init()
    init(_ array: [Scalar])
    init(_ other: Self)

    subscript(index: Int) -> Scalar { get set }
    subscript(safe index: Int) -> Scalar? { get set }

    mutating func set(_ array: [Scalar])
    mutating func set(_ other: Self)

    mutating func setToIdentity()
}


extension SwtMathObjectProtocol {
    @inlinable
    internal func commonDescription() -> String {
        var returnString: String = "\(type(of: self))("
        for i in indices {
            returnString += "\(self[i])"
            if i < (self.count - 1) {
                returnString += ", "
            }
        } 
        returnString += ")"
        return returnString
    }

    public var description: String {
        return commonDescription()
    }

    public func makeIterator() -> AnyIterator<Scalar> {
        var currentIndex = 0
        return AnyIterator {
            defer { currentIndex += 1 }
            return (currentIndex < self.count) ? self[currentIndex] : nil
        }
    }

    @inlinable
    public subscript(safe index: Int) -> Scalar? {
        get {
            guard index < count && index >= -count else { return nil }
            let i = (index >= 0) ? index : count + index
            return self[i]
        }
        set {
            guard index < count && index >= -count else { return }
            let i = (index >= 0) ? index : count + index
            self[i] = newValue!
        }
    }
}