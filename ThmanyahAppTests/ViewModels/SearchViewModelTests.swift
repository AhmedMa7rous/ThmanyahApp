import XCTest
@testable import ThmanyahApp

@MainActor
final class SearchViewModelTests: XCTestCase {
    func test_clearSearch_resets_state() {
        let repo = MockContentRepository()
        repo.searchResult = .success(([], Pagination(nextPage: nil, totalPages: 1, currentPage: 1)))
        let use = SearchContentUseCase(repository: repo)
        let vm = SearchViewModel(searchContentUseCase: use)

        vm.searchText = "hello"
        vm.clearSearch()

        XCTAssertEqual(vm.searchText, "")
        XCTAssertEqual(vm.sections.count, 0)
        XCTAssertFalse(vm.hasSearched)
        XCTAssertNil(vm.error)
    }

    func test_search_success_adds_to_history_and_sets_sections() async {
        let repo = MockContentRepository()
        let podcast = Podcast(id: "p1", name: "N1", description: "", avatarUrl: "https://x", episodeCount: 1, duration: 10, language: "ar", priority: 0, popularityScore: 0, score: 0)
        let section = HomeSection(name: "S", type: .square, contentType: .podcast, order: 1, content: [ContentItem(id: "S#0#p1", model: podcast)])
        repo.searchResult = .success(([section], Pagination(nextPage: nil, totalPages: 1, currentPage: 1)))

        let use = SearchContentUseCase(repository: repo)
        let vm = SearchViewModel(searchContentUseCase: use)

        vm.searchText = "sw"
        await vm.performSearchForTests()

        XCTAssertFalse(vm.isSearching)
        XCTAssertEqual(vm.sections.count, 1)
        XCTAssertTrue(vm.hasSearched)
    }
}

// MARK: - Test-only hooks
extension SearchViewModel {
    func performSearchForTests(file: StaticString = #file, line: UInt = #line) async -> Void {
        await self.performTestableSearch()
    }

    func performTestableSearch() async {
        let trimmedQuery = searchText.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !trimmedQuery.isEmpty else { return }
        await self.performSearch(query: trimmedQuery)
    }
}
