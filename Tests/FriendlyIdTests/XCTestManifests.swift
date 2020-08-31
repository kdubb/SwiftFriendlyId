import XCTest

#if !canImport(ObjectiveC)
public func allTests() -> [XCTestCaseEntry] {
  return [
    testCase(FriendlyIdTests.allTests),
    testCase(Base62Tests.allTests),
  ]
}
#endif
