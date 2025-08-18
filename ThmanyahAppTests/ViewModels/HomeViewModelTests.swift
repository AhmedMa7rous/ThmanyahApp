import XCTest
@testable import ThmanyahApp

@MainActor
final class HomeViewModelTests: XCTestCase {
    func test_loadInitialData_sets_sections_and_flags() async {
        // Arrange
        let repo = MockContentRepository()
        let podcast = Podcast(id: "p1", name: "N1", description: "", avatarUrl: "https://x", episodeCount: 1, duration: 10, language: "ar", priority: 0, popularityScore: 0, score: 0)
        let item = ContentItem(id: "S#0#p1", model: podcast)
        let section = HomeSection(name: "S", type: .square, contentType: .podcast, order: 1, content: [item])
        repo.homeResult = .success(([section], Pagination(nextPage: "2", totalPages: 2, currentPage: 1)))
        let useCase = FetchHomeSectionsUseCase(repository: repo)
        let vm = HomeViewModel(fetchHomeSectionsUseCase: useCase)

        // Act
        await vm.loadInitialData()

        // Assert
        XCTAssertFalse(vm.isLoading)
        XCTAssertTrue(vm.canLoadMore)
        XCTAssertEqual(vm.sections.count, 1)
        XCTAssertNil(vm.error)
    }

    func test_loadMore_appends_and_respects_canLoadMore() async {
        let repo = MockContentRepository()

        let mkSection: (String) -> HomeSection = { id in
            let podcast = Podcast(id: id, name: "N1", description: "", avatarUrl: "https://x", episodeCount: 1, duration: 10, language: "ar", priority: 0, popularityScore: 0, score: 0)
            return HomeSection(name: "S", type: .square, contentType: .podcast, order: 1, content: [ContentItem(id: "S#0#\(id)", model: podcast)])
        }
        repo.homeResult = .success(([mkSection("p1")], Pagination(nextPage: "2", totalPages: 2, currentPage: 1)))
        let useCase = FetchHomeSectionsUseCase(repository: repo)
        let vm = HomeViewModel(fetchHomeSectionsUseCase: useCase)

        await vm.loadInitialData()
        repo.homeResult = .success(([mkSection("p2")], Pagination(nextPage: nil, totalPages: 2, currentPage: 2)))
        await vm.loadMore()

        XCTAssertEqual(vm.sections.count, 2)
        XCTAssertFalse(vm.canLoadMore)
    }
}
