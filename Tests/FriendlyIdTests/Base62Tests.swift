//
//  Base62Tests.swift
//  
//
//  Created by Kevin Wooten on 8/31/20.
//

import Foundation
import XCTest
import FriendlyId

class Base62Tests: XCTestCase {

  var random = SystemRandomNumberGenerator()

  public func testDecodingValuePrefixedWithZeros() {
    XCTAssertEqual(Base62.encode(integer: Base62.decode(string: "00001")!), "1")
    XCTAssertEqual(Base62.encode(integer: Base62.decode(string: "01001")!), "1001")
    XCTAssertEqual(Base62.encode(integer: Base62.decode(string: "00abcd")!), "abcd")
  }
  
  public func testShouldReportBitWidthCorrectly() {
    XCTAssertGreaterThan(Base62.decode(string: "1Vkp6axDWu5pI3q1xQO3oO0")!.bitWidth, 128)
  }
  
  static var allTests = [
    ("testDecodingValuePrefixedWithZeros", testDecodingValuePrefixedWithZeros),
    ("testShouldReportBitWidthCorrectly", testShouldReportBitWidthCorrectly),
  ]

}
