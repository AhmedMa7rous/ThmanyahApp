import XCTest
@testable import ThmanyahApp

final class PaginationTests: XCTestCase {
    func test_flags() {
        let p1 = Pagination(nextPage: "2", totalPages: 3, currentPage: 1)
        XCTAssertTrue(p1.hasNextPage)
        XCTAssertFalse(p1.hasPreviousPage)
        XCTAssertFalse(p1.isLastPage)

        let pLast = Pagination(nextPage: nil, totalPages: 2, currentPage: 2)
        XCTAssertFalse(pLast.hasNextPage)
        XCTAssertTrue(pLast.isLastPage)
        XCTAssertTrue(pLast.hasPreviousPage)
    }
}
