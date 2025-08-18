import XCTest
@testable import ThmanyahApp

final class UseCasesTests: XCTestCase {
    func test_FetchHomeSectionsUseCase_validates_page() async {
        let repo = MockContentRepository()
        let useCase = FetchHomeSectionsUseCase(repository: repo)
        do {
            _ = try await useCase.execute(page: 0)
            XCTFail("Expected invalidPage")
        } catch let e as ValidationError {
            XCTAssertEqual(e, .invalidPage)
        } catch { XCTFail("Unexpected \(error)") }
    }

    func test_SearchContentUseCase_validates_query_and_page() async {
        let repo = MockContentRepository()
        let useCase = SearchContentUseCase(repository: repo)

        do {
            _ = try await useCase.execute(query: "   ", page: 1, limit: 20)
            XCTFail("Expected emptyQuery")
        } catch let e as ValidationError {
            XCTAssertEqual(e, .emptyQuery)
        } catch { XCTFail("Unexpected \(error)") }

        do {
            _ = try await useCase.execute(query: "ok", page: 0, limit: 20)
            XCTFail("Expected invalidPage")
        } catch let e as ValidationError {
            XCTAssertEqual(e, .invalidPage)
        } catch { XCTFail("Unexpected \(error)") }
    }
}
