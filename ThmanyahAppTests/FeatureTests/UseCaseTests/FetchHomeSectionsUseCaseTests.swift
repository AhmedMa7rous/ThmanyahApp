//
//  FetchHomeSectionsUseCaseTests.swift
//  ThmanyahApp
//
//  Created by Ahmed Mahrous on 16/08/2025.
//

import XCTest
@testable import ThmanyahApp

@MainActor
class FetchHomeSectionsUseCaseTests: XCTestCase {
    var sut: FetchHomeSectionsUseCase!
    var mockRepository: MockHomeRepository!
    
    override func setUp() {
        super.setUp()
        mockRepository = MockHomeRepository()
        sut = FetchHomeSectionsUseCase(repository: mockRepository)
    }
    
    override func tearDown() {
        sut = nil
        mockRepository = nil
        super.tearDown()
    }
    
    func testExecute_Success() async throws {
        // Given
        let expectedResponse = TestData.sampleHomeAPIResponse
        mockRepository.mockResponse = expectedResponse
        
        // When
        let result = try await sut.execute(page: 1, isRefresh: false)
        
        // Then
        XCTAssertEqual(result.sectionCount, 1)
        XCTAssertTrue(mockRepository.fetchHomeSectionsCalled)
    }
    
    func testExecute_SortsSectionsByOrder() async throws {
        // Given
        let item = TestData.sampleContentItem
        let section1 = HomeSection(name: "Section 1", type: .square, contentType: .podcast, order: 1, content: [item])
        let section2 = HomeSection(name: "Section 2", type: .square, contentType: .podcast, order: 2, content: [item])
        let response = HomeAPIResponse(sections: [section1, section2], pagination: nil)
        mockRepository.mockResponse = response

        // When
        let result = try await sut.execute(page: 1, isRefresh: false)

        // Then
        XCTAssertEqual(result.sections[0].order, 1)
        XCTAssertEqual(result.sections[1].order, 2)
        XCTAssertEqual(result.sectionCount, 2)
        XCTAssertEqual(result.sections.map(\.order), [1, 2])
    }
    
    func testExecute_FiltersEmptySections() async throws {
        // Given
        let emptySection = HomeSection(name: "Empty", type: .square, contentType: .podcast, order: 1, content: [])
        let nonEmptySection = TestData.sampleHomeSection
        let response = HomeAPIResponse(sections: [emptySection, nonEmptySection], pagination: nil)
        mockRepository.mockResponse = response
        
        // When
        let result = try await sut.execute(page: 1, isRefresh: false)
        
        // Then
        XCTAssertEqual(result.sectionCount, 1)
        XCTAssertEqual(result.sections[0].name, "Test Section")
    }
}
