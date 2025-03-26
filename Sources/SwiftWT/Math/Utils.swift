import Foundation

/** Checks whether or not two values are considered close according to given absolute and relative tolerances.

The IEEE 754 special values of NaN, inf, and -inf will be handled according to IEEE rules.
Specifically, NaN is not considered close to any other value, including NaN. 
infinite and -infinite are only considered close to themselves.
If no errors occur, the result will be: `abs(a-b) <= max(relTol * max(abs(a), abs(b)), absTol)`.

To check values close to zero, absTol should be always other than the default value of 0.0

- Parameter relTol: The maximum allowed difference between a and b, relative to the
    larger absolute value of a or b. 
    For example, to set a tolerance of 5%, pass `relTol: 0.05`.
    The default tolerance is 1e-09, which assures that the two values are the same within 
    about 9 decimal digits. relTol must be greater than zero.

- Parameter absTol: The minimum absolute tolerance – useful for comparisons near zero.  
    absTollerance must be at least zero.

- Returns: `true` if the values a and b are close to each other and `false` otherwise.
*/
@inlinable 
public func almostEqual<Scalar: BinaryFloatingPoint>(_ a: Scalar, _ b: Scalar, relTol: Scalar = Scalar.ulpOfOne.squareRoot(), absTol: Scalar = 0.0) -> Bool {        
    assert(relTol > Scalar.leastNormalMagnitude && relTol < 1.0)
    assert(absTol >= 0.0)
    
    if a.isNaN || b.isNaN { 
        return false 
    }
    
    // short-circuit exact equality. needed to catch two infinities of the same sign
    // and possibly speed things up a bit sometimes.
    if a == b { 
        return true
    }

    // This catches the case of two infinities of opposite sign, or one infinite and one finite number.
    // Two infinities of of opposite signes would otherwise have an infinite relative tolerance.
    // Two infinities of the same sign are caught by the equality check above
    if a.isInfinite || b.isInfinite { 
        return false 
    }
    
    let diff = abs(a - b)
    // this is esentaily the "weak"test for the C++ boost library
    return diff <= abs(relTol * b) || diff <= abs(relTol * a) || diff <= absTol
}

public func almostEqual<T: MathObjectProtocol>(_ a: T, _ b: T, relTol: T.Scalar = T.Scalar.ulpOfOne.squareRoot(), absTol: T.Scalar = 0.0) -> Bool
where T.Scalar: BinaryFloatingPoint {
    for i in 0..<a.count {
        if !almostEqual(a[i], b[i], relTol: relTol, absTol: absTol) {
            return false
        }
    }
    return true
}

@inlinable
public func almostZero<Scalar: BinaryFloatingPoint>(_ a: Scalar, tol: Scalar = Scalar.ulpOfOne.squareRoot()) -> Bool {
    return almostEqual(0.0, a, absTol: tol);
}

@inlinable
public func toRadians<Scalar: BinaryFloatingPoint>(_ x: Scalar) -> Scalar {
    return x * (Scalar.pi / 180.0)
}

@inlinable
public func toRadians<Scalar: BinaryFloatingPoint>(_ x: inout Scalar) {
    x *= (Scalar.pi / 180.0)
}

@inlinable
public func toDegrees<Scalar: BinaryFloatingPoint>(_ x: Scalar) -> Scalar {
    return x * (180.0 / Scalar.pi)
}

@inlinable
public func toDegrees<Scalar: BinaryFloatingPoint>(_ x: inout Scalar) {
    x *= (180.0 / Scalar.pi)
}

@inlinable
public func clamped<Scalar: Comparable>(_ value: Scalar, from lowerBound: Scalar, to upperBound: Scalar) -> Scalar {
    return max(min(value, upperBound), lowerBound)
}
