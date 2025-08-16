//
//  SearchContentUseCaseTests.swift
//  ThmanyahApp
//
//  Created by Ahmed Mahrous on 16/08/2025.
//

import XCTest
@testable import ThmanyahApp

@MainActor
class SearchContentUseCaseTests: XCTestCase {
    var sut: SearchContentUseCase!
    var mockRepository: MockSearchRepository!
    
    override func setUp() {
        super.setUp()
        mockRepository = MockSearchRepository()
        sut = SearchContentUseCase(repository: mockRepository)
    }
    
    override func tearDown() {
        sut = nil
        mockRepository = nil
        super.tearDown()
    }
    
    func testExecute_Success() async throws {
        // Given
        let expectedResponse = TestData.sampleSearchResponse
        mockRepository.mockResponse = expectedResponse
        
        // When
        let result = try await sut.execute(query: "test query", page: 1)
        
        // Then
        XCTAssertEqual(result.resultCount, 1)
        XCTAssertTrue(mockRepository.searchCalled)
    }
    
    func testExecute_EmptyQuery() async throws {
        // When
        let result = try await sut.execute(query: "", page: 1)
        
        // Then
        XCTAssertEqual(result.resultCount, 0)
        XCTAssertFalse(mockRepository.searchCalled)
    }
    
    func testExecute_QueryTooShort() async {
        // When/Then
        do {
            _ = try await sut.execute(query: "a", page: 1)
            XCTFail("Should have thrown queryTooShort error")
        } catch SearchError.queryTooShort {
            // Expected
        } catch {
            XCTFail("Unexpected error: \(error)")
        }
    }
    
    func testExecute_SortsByScore() async throws {
        // Given
        let item1 = ContentItem(name: "Item 1", description: nil, avatarURL: nil, duration: nil, language: nil, score: 50.0, podcastId: "1", episodeCount: nil, priority: nil, popularityScore: nil, episodeId: nil, seasonNumber: nil, episodeType: nil, podcastName: nil, authorName: nil, number: nil, audioURL: nil, separatedAudioURL: nil, releaseDate: nil, chapters: nil, podcastPopularityScore: nil, podcastPriority: nil, audiobookId: nil, articleId: nil)
        let item2 = ContentItem(name: "Item 2", description: nil, avatarURL: nil, duration: nil, language: nil, score: 100.0, podcastId: "2", episodeCount: nil, priority: nil, popularityScore: nil, episodeId: nil, seasonNumber: nil, episodeType: nil, podcastName: nil, authorName: nil, number: nil, audioURL: nil, separatedAudioURL: nil, releaseDate: nil, chapters: nil, podcastPopularityScore: nil, podcastPriority: nil, audiobookId: nil, articleId: nil)
        
        let response = SearchResponse(results: [item1, item2], totalCount: 2, pagination: nil)
        mockRepository.mockResponse = response
        
        // When
        let result = try await sut.execute(query: "test", page: 1)
        
        // Then
        XCTAssertEqual(result.results[0].score, 100.0)
        XCTAssertEqual(result.results[1].score, 50.0)
    }
}
