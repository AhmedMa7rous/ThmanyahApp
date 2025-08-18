import XCTest
@testable import ThmanyahApp

final class ContentRepositoryTests: XCTestCase {
    func test_fetchHomeSections_happyPath() async throws {
        let mock = MockNetworkService()
        mock.mode = .success { endpoint in
            switch endpoint {
            case .homeSections: return TestJSON.homeSuccess
            default: return Data()
            }
        }
        let repo = ContentRepository(networkService: mock)
        let result = try await repo.fetchHomeSections(page: 1)
        XCTAssertEqual(result.sections.count, 2)
        XCTAssertEqual(result.pagination.totalPages, 3)
    }

    func test_searchContent_builds_sections_from_searchDTO() async throws {
        let mock = MockNetworkService()
        mock.mode = .success { endpoint in
            switch endpoint {
            case .search(_, _, _): return TestJSON.searchSuccess
            default: return Data()
            }
        }
        let repo = ContentRepository(networkService: mock)
        let result = try await repo.searchContent(query: "ar", page: 1, limit: 20)
        XCTAssertEqual(result.sections.count, 1)
        XCTAssertEqual(result.sections.first?.content.first?.model.contentType, .audioBook)
        XCTAssertFalse(result.pagination.hasNextPage)
    }
}
