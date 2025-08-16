//
//  SearchRepositoryTests.swift
//  ThmanyahApp
//
//  Created by Ahmed Mahrous on 16/08/2025.
//

import XCTest
@testable import ThmanyahApp

@MainActor
class SearchRepositoryTests: XCTestCase {
    var sut: SearchRepository!
    var mockNetworkService: MockNetworkService!
    
    override func setUp() {
        super.setUp()
        mockNetworkService = MockNetworkService()
        sut = SearchRepository(networkService: mockNetworkService)
    }
    
    override func tearDown() {
        sut = nil
        mockNetworkService = nil
        super.tearDown()
    }
    
    func testSearch_Success() async throws {
        // Given
        let expectedResponse = SearchResponse(
            results: [TestData.sampleContentItem],
            totalCount: 1,
            pagination: TestData.samplePagination
        )
        mockNetworkService.mockResponse = expectedResponse
        
        // When
        let result = try await sut.search(query: "test", page: 1)
        
        // Then
        XCTAssertEqual(result.resultCount, 1)
        XCTAssertEqual(result.results.first?.name, "Test Content")
    }
    
    func testSearch_EmptyQuery() async throws {
        // Given
        let expectedResponse = SearchResponse(results: [], totalCount: 0, pagination: nil)
        mockNetworkService.mockResponse = expectedResponse
        
        // When
        let result = try await sut.search(query: "", page: 1)
        
        // Then
        XCTAssertEqual(result.resultCount, 0)
        XCTAssertTrue(result.isEmpty)
    }
}
