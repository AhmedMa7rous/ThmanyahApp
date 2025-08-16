//
//  SearchViewModelTests.swift
//  ThmanyahApp
//
//  Created by Ahmed Mahrous on 16/08/2025.
//

import XCTest
@testable import ThmanyahApp

@MainActor
class SearchViewModelTests: XCTestCase {
    var sut: SearchViewModel!
    var mockUseCase: MockSearchContentUseCase!
    
    override func setUp() {
        super.setUp()
        mockUseCase = MockSearchContentUseCase()
        sut = SearchViewModel(searchUseCase: mockUseCase)
    }
    
    override func tearDown() {
        sut = nil
        mockUseCase = nil
        super.tearDown()
    }
    
    func testSearchContent_Success() async {
        // Given
        let expectedResponse = TestData.sampleSearchResponse
        mockUseCase.mockResponse = expectedResponse
        sut.searchText = "test query"
        
        // When
        sut.searchContent()
        
        // Wait for debounce
        try? await Task.sleep(nanoseconds: 300_000_000)
        
        // Then
        XCTAssertEqual(sut.searchResults.count, 1)
        XCTAssertEqual(sut.totalCount, 1)
        XCTAssertEqual(sut.paginationState, .loaded)
        XCTAssertTrue(mockUseCase.executeCalled)
    }
    
    func testSearchContent_EmptyQuery() {
        // Given
        sut.searchText = ""
        
        // When
        sut.searchContent()
        
        // Then
        XCTAssertTrue(sut.searchResults.isEmpty)
        XCTAssertEqual(sut.totalCount, 0)
        XCTAssertFalse(mockUseCase.executeCalled)
    }
    
    func testSearchContent_Failure() async {
        // Given
        mockUseCase.mockError = NetworkError.networkError("Search failed")
        sut.searchText = "test"
        
        // When
        sut.searchContent()
        
        // Wait for debounce
        try? await Task.sleep(nanoseconds: 300_000_000)
        
        // Then
        XCTAssertTrue(sut.searchResults.isEmpty)
        XCTAssertEqual(sut.paginationState, .error("Network error: Search failed"))
        XCTAssertNotNil(sut.errorMessage)
    }
    
    func testLoadMoreResults_Success() async {
        // Given - First perform a search
        let initialResponse = TestData.sampleSearchResponse
        mockUseCase.mockResponse = initialResponse
        sut.searchText = "test"
        sut.searchContent()
        try? await Task.sleep(nanoseconds: 300_000_000)
        
        // Setup for load more
        let additionalItem = ContentItem(name: "Additional Item", description: nil, avatarURL: nil, duration: nil, language: nil, score: nil, podcastId: "456", episodeCount: nil, priority: nil, popularityScore: nil, episodeId: nil, seasonNumber: nil, episodeType: nil, podcastName: nil, authorName: nil, number: nil, audioURL: nil, separatedAudioURL: nil, releaseDate: nil, chapters: nil, podcastPopularityScore: nil, podcastPriority: nil, audiobookId: nil, articleId: nil)
        let moreResponse = SearchResponse(results: [additionalItem], totalCount: 2, pagination: TestData.samplePagination)
        mockUseCase.mockResponse = moreResponse
        
        // When
        await sut.loadMoreResults()
        
        // Then
        XCTAssertEqual(sut.searchResults.count, 2)
        XCTAssertEqual(sut.paginationState, .loaded)
    }
    
    func testClearSearch() {
        // Given
        sut.searchText = "test"
        sut.searchResults = [TestData.sampleContentItem]
        sut.totalCount = 1
        
        // When
        sut.clearSearch()
        
        // Then
        XCTAssertTrue(sut.searchText.isEmpty)
        XCTAssertTrue(sut.searchResults.isEmpty)
        XCTAssertEqual(sut.totalCount, 0)
        XCTAssertEqual(sut.paginationState, .idle)
    }
    
    func testComputedProperties() {
        // Given
        sut.searchResults = [TestData.sampleContentItem]
        sut.totalCount = 1
        
        // Then
        XCTAssertTrue(sut.hasResults)
        XCTAssertFalse(sut.isEmpty)
        XCTAssertEqual(sut.resultCount, 1)
        XCTAssertEqual(sut.formattedResultCount, "1 result")
    }
    
    func testFormattedResultCount_Multiple() {
        // Given
        sut.totalCount = 5
        
        // Then
        XCTAssertEqual(sut.formattedResultCount, "5 results")
    }
    
    func testFormattedResultCount_Zero() {
        // Given
        sut.totalCount = 0
        
        // Then
        XCTAssertEqual(sut.formattedResultCount, "No results")
    }
}
