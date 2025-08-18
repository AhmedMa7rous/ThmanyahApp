import XCTest
@testable import ThmanyahApp

final class ExtensionsTests: XCTestCase {
    func test_string_isValidSearchQuery() {
        XCTAssertFalse(" ".isValidSearchQuery)
        XCTAssertFalse("a".isValidSearchQuery)
        XCTAssertTrue("ab".isValidSearchQuery)
    }

    func test_string_truncated() {
        XCTAssertEqual("abc".truncated(to: 5), "abc")
        XCTAssertEqual("abcdefgh".truncated(to: 5), "abcde...")
    }
}
