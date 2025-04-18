import Foundation

enum SwtMathErrors: Error, LocalizedError {
    case LengthIsZero
    case OutOfRange
    case DivisionByZero

    var errorDescription: String? {
        switch self {
        case .LengthIsZero:
            return "Cannot normalize a Vector if its length is zero"
        case .OutOfRange:
            return "Value was out of the allowed range"
        case .DivisionByZero:
            return "Division by zero occurred"
        }
    }
}