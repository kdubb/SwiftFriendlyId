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
  
  static var allTests = [
    ("testIdGenerate", testIdGenerate),
    ("testIdEqualaity", testIdEqualaity),
  ]
}
