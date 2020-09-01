import XCTest
@testable import FriendlyId

final class FriendlyIdTests: XCTestCase {
  
  var random = SystemRandomNumberGenerator()
  let nullUUID: uuid_t = (0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0)

  public func testEncodingUuidShouldBeReversible() {
    Gen.uuids(using: &random)
      .prefix(10000)
      .forEach { uuid in
        XCTAssertTrue(decode(string: encode(uuid: uuid)) ?? nullUUID == uuid)
      }
  }
  
  public func testDecodingIdShouldBeReversible() {
    Gen.ids(using: &random)
      .prefix(10000)
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
