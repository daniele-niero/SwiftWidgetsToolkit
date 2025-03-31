enum SwtMathErrors: Error {
    case LengthIsZero(String)
    case OutOfRange(String)
    case DivisionByZero(String)
}