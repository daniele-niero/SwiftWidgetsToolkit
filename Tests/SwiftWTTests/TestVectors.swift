import Testing
@testable import SwiftWT
import Foundation

@Suite
class SwtVectorsTests {

    @Test("SwtVectors initialization")
    func testCreation() {
        var v1 = SwtVector3<Float>()
        #expect(v1.x == 0.0)
        #expect(v1.y == 0.0)
        #expect(v1.z == 0.0)

        var v2 = SwtVector4<Double>(1, 2, 3, 4)
        #expect(v2.x == 1.0)
        #expect(v2.y == 2.0)
        #expect(v2.z == 3.0)
        #expect(v2.w == 4.0)

        var v3 = SwtVector2<Int>(1, 2)
        #expect(v3.x == 1)
        #expect(v3.y == 2)

        v1 = SwtVector3<Float>([0.0, 0.0, 0.0])
        #expect(v1.x == 0.0)
        #expect(v1.y == 0.0)
        #expect(v1.z == 0.0)

        v2 = SwtVector4<Double>([1, 2, 3, 4])
        #expect(v2.x == 1.0)
        #expect(v2.y == 2.0)
        #expect(v2.z == 3.0)
        #expect(v2.w == 4.0)

        v3 = SwtVector2<Int>([1, 2])
        #expect(v3.x == 1)
        #expect(v3.y == 2)
    }

    @Test("Set To Identity")
    func testSetToIdentity() {
        var v1 = SwtVector3<Float>(1.0, 2.0, 3.0)
        v1.setToIdentity()
        #expect(v1.x == 0.0)
        #expect(v1.y == 0.0)
        #expect(v1.z == 0.0)

        var v2 = SwtVector3<Int>(1, 2, 3)
        v2.setToIdentity()
        #expect(v2.x == 0)
        #expect(v2.y == 0)
        #expect(v2.z == 0)

        var v3 = SwtVector2<Int>(1, 2)
        v3.setToIdentity()
        #expect(v3.x == 0)
        #expect(v3.y == 0)
    }

    @Test("Sum")
    func testSum() {
        let v1 = SwtVector3<Float>(1.0, 2.0, 3.0)
        #expect(v1._data.sum() == 6.0)

        let v2 = SwtVector2<Double>(1.0, 2.0)
        #expect(v2._data.sum() == 3.0)
    }

    @Test("Normalization")
    func testNormalization() {
        var v1 = SwtVector3<Float>(0.0, 2.0, 0.0)
        let n: SwtVector3<Float> = try! v1.normalize()
        #expect(n == SwtVector3<Float>(0.0, 1.0, 0.0))

        v1.set(0.0, 0.0, 0.000)
        #expect(throws: SwtMathErrors.LengthIsZero.self) {
            try v1.normalize()
        }
        let n2 = try? v1.normalize()
        #expect(n2 == nil)
    }

    @Test("Cross Product")
    func testCrossProduct() {
        let v1 = SwtVector3<Double>(0.0, 1.0, 0.0)
        let v2 = SwtVector3<Double>(1.0, 0.0, 0.0)
        let v3 = v1.cross(v2)

        #expect(v3 == SwtVector3<Double>(0.0, 0.0, -1.0))
    }

    @Test("Arithmetic With Single Number")
    func testArithmeticWithSingleNumber() {
        let x = 2.5
        let vec = SwtVector3<Double>(1.0, 2.0, 3.0)
        var result: SwtVector3<Double>

        result = vec * x
        var answer: [Double] = [2.5, 5.0, 7.5]
        for i in answer.indices {
            #expect(result[i] == answer[i])
        }

        result = vec + x
        answer = [3.5, 4.5, 5.5]
        for i in answer.indices {
            #expect(result[i] == answer[i])
        }

        result = vec / x
        answer = [1.0 / x, 2.0 / x, 3.0 / x]
        for i in answer.indices {
            #expect(result[i] == answer[i])
        }
    }

    @Test("Arithmetic With Another Vector")
    func testArithmeticWithAnotherVector() {
        let vec1 = SwtVector3<Double>(1.0, 2.0, 3.0)
        let vec2 = SwtVector3<Double>(1.0, 2.0, 3.0)
        var result: SwtVector3<Double>

        result = vec1 * vec2
        var answer = SwtVector3<Double>(1.0, 4.0, 9.0)
        #expect(result == answer)

        result = vec1 + vec2
        answer.set(2.0, 4.0, 6.0)
        #expect(result == answer)

        result = vec1 / vec2
        answer.set(1.0, 1.0, 1.0)
        #expect(result == answer)
    }

    @Test("Length")
    func testLength() {
        var v1 = SwtVector3<Float>(0, 12, 0)
        let answer = SwtVector3<Float>(0, 1, 0)

        let norm = try! v1.normalize()
        #expect(norm == answer)

        #expect(v1 != answer)
        try? v1.normalized()
        #expect(v1 == answer)
    }

    @Test("Dot Product")
    func testDot() {
        var v1 = SwtVector3<Float>(0, 1, 0)
        let v2 = SwtVector3<Float>(1, 0, 0)

        var dot = v1.dot(v2)
        #expect(dot == 0.0)
        #expect(almostEqual(acos(dot), Float.pi / 2.0))

        v1.x = 1.0
        try! v1.normalized()
        dot = v1.dot(v2)
        #expect(almostEqual(dot, 0.7071))
        #expect(almostEqual(acos(dot), Float.pi / 4.0))

        v1.x = 1.0
        v1.y = 0.0
        dot = v1.dot(v2)
        #expect(dot == 1.0)
        #expect(almostEqual(acos(dot), 0.0))

        v1.x = -1.0
        dot = v1.dot(v2)
        #expect(dot == -1.0)
        #expect(almostEqual(acos(dot), Float.pi))
    }

    @Test("Distance")
    func testDistance() {
        var v1 = SwtVector3<Float16>(2, 0, 0)
        var v2 = SwtVector3<Float16>(4, 0, 0)

        #expect(v1.squaredDistance(to: v2) == 4.0)
        #expect(v1.distance(to: v2) == 2.0)

        v1[1] = 2.0; v1.z = 2.0
        v2.y = 4.0; v2.z = 4.0

        #expect(v1.distance(to: v2) == 3.4641016)
    }

    @Test("Iteration")
    func testIteration() {
        var values: [Float] = [1.0, 2.0, 3.0]
        let v1 = SwtVector3<Float>(values)

        var i = 0
        for val in v1 {
            #expect(val == values[i])
            i += 1
        }


        values = [1.0, 2.0]
        let v2 = SwtVector2<Float>(values)

        i = 0
        for val in v2 {
            #expect(val == values[i])
            i += 1
        }


        let ivalues: [Int8] = [1, 2, 3, 4]
        let v3 = SwtVector4<Int8>(ivalues)

        i = 0
        for val in v3 {
            #expect(val == ivalues[i])
            i += 1
        }
    }

    @Test("Encode and Decode")
    func testEncodeDecode() {
        let v1 = SwtVector3<Float>(1.0, 2.0, 3.0)
        let data = try! JSONEncoder().encode(v1)

        // print the data
        let serializedString = String(data: data, encoding: .utf8)!
        #expect(serializedString == "{\"_data\":[1,2,3]}")


        let v2 = try! JSONDecoder().decode(SwtVector3<Float>.self, from: data)
        #expect(v1 == v2)

        print(v1.description)
    }

    @Test("Subscript")
    func testSubscript() {
        let a = SwtVector3(1.0, 2.0, 3.0)
        #expect(a[0] == 1.0)
        #expect(a[1] == 2.0)
        #expect(a[2] == 3.0)
        #expect(a[safe: 3]  == nil)
        #expect(a[safe: -4] == nil)
        #expect(a[safe: -3] == 1.0)
        #expect(a[safe: -2] == 2.0)
        #expect(a[safe: -1] == 3.0)
    }
}
