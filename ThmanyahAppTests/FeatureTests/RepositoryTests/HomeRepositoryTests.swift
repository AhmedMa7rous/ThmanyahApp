//
//  HomeRepositoryTests.swift
//  ThmanyahApp
//
//  Created by Ahmed Mahrous on 16/08/2025.
//

import XCTest
@testable import ThmanyahApp

@MainActor
class HomeRepositoryTests: XCTestCase {
    var sut: HomeRepository!
    var mockNetworkService: MockNetworkService!
    
    override func setUp() {
        super.setUp()
        mockNetworkService = MockNetworkService()
        sut = HomeRepository(networkService: mockNetworkService)
    }
    
    override func tearDown() {
        sut = nil
        mockNetworkService = nil
        super.tearDown()
    }
    
    func testFetchHomeSections_Success() async throws {
        // Given
        let expectedResponse = HomeAPIResponse(
            sections: [TestData.sampleHomeSection],
            pagination: TestData.samplePagination
        )
        mockNetworkService.mockResponse = expectedResponse
        
        // When
        let result = try await sut.fetchHomeSections(page: 1)
        
        // Then
        XCTAssertEqual(result.sectionCount, 1)
        XCTAssertEqual(result.sections.first?.name, "Test Section")
    }
    
    func testFetchHomeSections_NetworkError() async {
        // Given
        mockNetworkService.mockError = NetworkError.networkError("Test error")
        
        // When/Then
        do {
            _ = try await sut.fetchHomeSections(page: 1)
            XCTFail("Should have thrown an error")
        } catch let error as NetworkError {
            XCTAssertEqual(error, NetworkError.networkError("Test error"))
        } catch {
            XCTFail("Expected NetworkError.networkError but got \(error)")
        }
    }
}
