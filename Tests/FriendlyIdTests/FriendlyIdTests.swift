import XCTest
@testable import FriendlyId

final class FriendlyIdTests: XCTestCase {
  
  var random = SystemRandomNumberGenerator()
  
  public func testEncodingUuidShouldBeReversible() {
    Gen.uuids(using: &random)
      .prefix(3000)
      .forEach { uuid in
        XCTAssertEqual(decode(string: encode(uuid: uuid)), uuid)
      }
  }
  
  public func testDecodingIdShouldBeReversible() {
    Gen.ids(using: &random)
      .prefix(3000)
      .forEach { id in
        guard let uuid = decode(string: id) else {
          return XCTFail("decode failed")
        }
        XCTAssertEqual(String(encode(uuid: uuid).drop { $0 == "0" }), id)
      }
  }
  
  static var allTests = [
    ("testEncodingUuidShouldBeReversible", testEncodingUuidShouldBeReversible),
    ("testDecodingIdShouldBeReversible", testDecodingIdShouldBeReversible),
  ]
}
