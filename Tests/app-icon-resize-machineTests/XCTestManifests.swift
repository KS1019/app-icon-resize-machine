import XCTest

#if !canImport(ObjectiveC)
public func allTests() -> [XCTestCaseEntry] {
    return [
        testCase(app_icon_resize_machineTests.allTests),
    ]
}
#endif
