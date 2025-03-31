import Testing
@testable import SwiftWT
import Foundation

@Suite
class SwtVectorsTests {

    @Test("SwtVector3 initialization")
    func testCreation() {
        let v1 = SwtVector3<Float>()
        #expect(v1.x == 0.0)
        #expect(v1.y == 0.0)
        #expect(v1.z == 0.0)

        let v2 = SwtVector3<Double>(1, 2, 3)
        #expect(v2.x == 1.0)
        #expect(v2.y == 2.0)
        #expect(v2.z == 3.0)

        let v3 = SwtVector3<Int>(1, 2, 3)
        #expect(v3.x == 1)
        #expect(v3.y == 2)
        #expect(v3.z == 3)
    }

    @Test("Set To Identity")
    func testSetToIdentity() {
        var v1 = SwtVector3<Float>(1.0, 2.0, 3.0)
        v1.setToIdentity()
        #expect(v1.x == 0.0)
        #expect(v1.y == 0.0)
        #expect(v1.z == 0.0)

        // var v2 = SwtVector3<Int>(1, 2, 3)
        // v2.setToIdentity()
        // #expect(v2.x == 0)
        // #expect(v2.y == 0)
        // #expect(v2.z == 0)
    }

    // func testSum() {
    //     let v1 = Vector(1.0, 2.0, 3.0)
    //     XCTAssertEqual(v1._simdData.sum(), 6.0)
    // }

    // func testNormalization() {
    //     var v1 = Vector(0.0, 2.0, 0.0)
    //     let n = try! v1.normalized() 
    //     XCTAssertEqual(n, Vector(0.0, 1.0, 0.0))

    //     v1.set(0.0, 0.0, 0.000)
    //     XCTAssertThrowsError(try v1.normalize())
    //     let n2 = try? v1.normalize()
    //     XCTAssertTrue(n2 == nil)
    // }

    // func testCrossProduct() {
    //     let v1 = Vector<Double>(0.0, 1.0, 0.0)
    //     let v2 = Vector<Double>(1.0, 0.0, 0.0)
    //     let v3 = v1.crossed(v2)
    //     print(v3)

    //     XCTAssertTrue(v3 == Vector<Double>(0.0, 0.0, -1.0))
    // }

    // func testArithmeticWithSingleNumber() {
    //     let x = 2.5
    //     let vec = Vector<Double>(1.0, 2.0, 3.0)
    //     var result: Vector<Double>

    //     result = vec * x
    //     var answer: [Double] = [2.5, 5.0, 7.5]
    //     for i in answer.indices {
    //         XCTAssertEqual(result[i], answer[i], "\(result[i]) != \(answer[i])")
    //     }

    //     result = vec + x
    //     answer = [3.5, 4.5, 5.5]
    //     for i in answer.indices {
    //         XCTAssertEqual(result[i], answer[i], "\(result[i]) != \(answer[i])")
    //     }

    //     result = vec / x
    //     answer = [1.0 / x, 2.0 / x, 3.0 / x]
    //     for i in answer.indices {
    //         XCTAssertEqual(result[i], answer[i], "\(result[i]) != \(answer[i])")
    //     }
    // }

    // func testArithmeticWithAnotherVector() {
    //     let vec1 = Vector<Double>(1.0, 2.0, 3.0)
    //     let vec2 = Vector<Double>(1.0, 2.0, 3.0)
    //     var result: Vector<Double>

    //     result = vec1 * vec2
    //     var answer: [Double] = [1.0, 4.0, 9.0]
    //     for i in answer.indices {
    //         XCTAssertEqual(result[i], answer[i], "\(result[i]) != \(answer[i])")
    //     }

    //     result = vec1 + vec2
    //     answer = [2.0, 4.0, 6.0]
    //     for i in answer.indices {
    //         XCTAssertEqual(result[i], answer[i], "\(result[i]) != \(answer[i])")
    //     }

    //     result = vec1 / vec2
    //     answer = [1.0, 1.0, 1.0]
    //     for i in answer.indices {
    //         XCTAssertEqual(result[i], answer[i], "\(result[i]) != \(answer[i])")
    //     }
    // }

    // func testLength() {
    //     let v1 = Vector<Float>(0, 12, 0)
    //     let answer = Vector<Float>(0, 1, 0)

    //     let norm = try! v1.normalized()
    //     XCTAssertEqual(norm, answer)
    //     XCTAssertFalse(v1 == answer)
    // }

    // func testDot() {
    //     var v1 = Vector<Float>(0, 1, 0)
    //     let v2 = Vector<Float>(1, 0, 0)

    //     var dot = v1.dot(v2)
    //     XCTAssertEqual(dot, 0.0)
    //     XCTAssertTrue(almostEqual(acos(dot), Float.pi / 2.0))

    //     v1.x = 1.0
    //     try! v1.normalize()
    //     dot = v1.dot(v2)
    //     XCTAssertTrue(almostEqual(dot, 0.7071))
    //     XCTAssertTrue(almostEqual(acos(dot), Float.pi / 4.0))

    //     v1.x = 1.0
    //     v1.y = 0.0
    //     dot = v1.dot(v2)
    //     XCTAssertEqual(dot, 1.0)
    //     XCTAssertTrue(almostEqual(acos(dot), 0.0))

    //     v1.x = -1.0
    //     dot = v1.dot(v2)
    //     XCTAssertEqual(dot, -1.0)
    //     XCTAssertTrue(almostEqual(acos(dot), Float.pi))
    // }

    // func testDistance() {
    //     var v1 = Vector<Float16>(2, 0, 0)
    //     var v2 = Vector<Float16>(4, 0, 0)

    //     XCTAssertEqual(v1.squaredDistance(to: v2), 4.0)
    //     XCTAssertEqual(v1.distance(to: v2), 2.0)

    //     print(v1)
    //     v1[1] = 2.0; v1.z = 2.0
    //     print(v1)
    //     v2.y = 4.0; v2.z = 4.0

    //     XCTAssertEqual(v1.distance(to: v2), 3.4641016)
    // }

    // func testIteration() {
    //     let values = [1.0, 2.0, 3.0]
    //     let q = Vector(values[0], values[1], values[2])

    //     var i = 0
    //     for val in q {
    //         XCTAssertEqual(val, values[i])
    //         i += 1
    //     }
    // }

    // func testEncodeDecode() {
    //     let v1 = Vector<Float>(1.0, 2.0, 3.0)
    //     let data = try! JSONEncoder().encode(v1)
        
    //     // print the data
    //     print(String(data: data, encoding: .utf8)!)

    //     let v2 = try! JSONDecoder().decode(Vector<Float>.self, from: data)
    //     XCTAssertEqual(v1, v2)
    // }

    // func testSubscript() {
    //     let a = Vector(1.0, 2.0, 3.0)
    //     XCTAssertEqual(a[0], 1.0)
    //     XCTAssertEqual(a[1], 2.0)
    //     XCTAssertEqual(a[2], 3.0)
    //     XCTAssertNil(a[safe: 3])
    //     XCTAssertNil(a[safe: -4])
    //     XCTAssertEqual(a[safe: -3], 1.0)
    //     XCTAssertEqual(a[safe: -2], 2.0)
    //     XCTAssertEqual(a[safe: -1], 3.0)
    // }
}
