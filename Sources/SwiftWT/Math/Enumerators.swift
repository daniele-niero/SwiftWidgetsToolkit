 enum NMathErrors: Error {
    case LengthIsZero(String)
    case OutOfRange(String)
    case DivisionByZero(String)
 }

 public enum Unit: String, Codable {
    case degrees
    case radians
}

public enum RotationOrder: Int {
    case XYZ = 0
    case XZY = 1
    case YXZ = 2
    case YZX = 3
    case ZXY = 4
    case ZYX = 5
}

public enum Axis: Int {
    case NEGX = -1
    case NEGY = -2
    case NEGZ = -3
    case POSX = 1
    case POSY = 2
    case POSZ = 3

    @inlinable
    public func isX() -> Bool {
        self == .POSX || self == .NEGX
    }
    
    @inlinable
    public func isY() -> Bool {
        self == .POSY || self == .NEGY
    }

    @inlinable
    public func isZ() -> Bool {
        self == .POSZ || self == .NEGZ
    }
}

public enum CartesianPlane{
    case XY
    case YZ
    case ZX

    case YX
    case ZY
    case XZ
}

