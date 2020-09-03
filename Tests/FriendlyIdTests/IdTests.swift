import Foundation
import XCTest
@testable import FriendlyId

final class IdTests: XCTestCase {
  
  public func testIdGenerate() {
    _ = Id(algorithm: .time)
    _ = Id(algorithm: .random)
  }
  
  public func testIdEqualaity() {
    let id = Id(algorithm: .time)
    XCTAssertEqual(id, id)
  }
  
  public func testCodable() throws {
    let id = Id()
    let encoded = try JSONEncoder().encode(id)
    let result = try JSONDecoder().decode(Id.self, from: encoded)
    XCTAssertEqual(id, result)
  }
  
  public func testCodableIsSimple() throws {
    let id = Id(string: "2Ig8EpbhyAuG7iSqDWES9O")
    let result = try JSONDecoder().decode(Id.self, from: #""2Ig8EpbhyAuG7iSqDWES9O""#.data(using: .utf8)!)
    XCTAssertEqual(id, result)
  }

  static var allTests = [
    ("testIdGenerate", testIdGenerate),
    ("testIdEqualaity", testIdEqualaity),
  ]
}
