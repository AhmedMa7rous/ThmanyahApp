//
//  HomeViewModelTests.swift
//  ThmanyahApp
//
//  Created by Ahmed Mahrous on 16/08/2025.
//

import XCTest
@testable import ThmanyahApp

@MainActor
class HomeViewModelTests: XCTestCase {
    var sut: HomeViewModel!
    var mockUseCase: MockFetchHomeSectionsUseCase!
    
    override func setUp() {
        super.setUp()
        mockUseCase = MockFetchHomeSectionsUseCase()
        sut = HomeViewModel(fetchHomeSectionsUseCase: mockUseCase)
    }
    
    override func tearDown() {
        sut = nil
        mockUseCase = nil
        super.tearDown()
    }
    
    func testLoadHomeSections_Success() async {
        // Given
        let expectedResponse = TestData.sampleHomeAPIResponse
        mockUseCase.mockResponse = expectedResponse
        
        // When
        await sut.loadHomeSections()
        
        // Then
        XCTAssertEqual(sut.sections.count, 1)
        XCTAssertEqual(sut.sections.first?.name, "Test Section")
        XCTAssertEqual(sut.paginationState, .loaded)
        XCTAssertNil(sut.errorMessage)
        XCTAssertTrue(mockUseCase.executeCalled)
    }
    
    func testLoadHomeSections_Failure() async {
        // Given
        mockUseCase.mockError = NetworkError.networkError("Test error")
        
        // When
        await sut.loadHomeSections()
        
        // Then
        XCTAssertTrue(sut.sections.isEmpty)
        XCTAssertEqual(sut.paginationState, .error("Network error: Test error"))
        XCTAssertNotNil(sut.errorMessage)
    }
    
    func testRefresh_Success() async {
        // Given
        let expectedResponse = TestData.sampleHomeAPIResponse
        mockUseCase.mockResponse = expectedResponse
        
        // When
        await sut.refresh()
        
        // Then
        XCTAssertEqual(sut.sections.count, 1)
        XCTAssertEqual(sut.paginationState, .loaded)
        XCTAssertTrue(mockUseCase.isRefreshCalled)
    }
    
    func testLoadMoreSections_Success() async {
        // Given - First load some initial sections
        let initialResponse = TestData.sampleHomeAPIResponse
        mockUseCase.mockResponse = initialResponse
        await sut.loadHomeSections()
        
        // Setup for load more
        let additionalSection = HomeSection(name: "Additional Section", type: .square, contentType: .podcast, order: 2, content: [TestData.sampleContentItem])
        let moreResponse = HomeAPIResponse(sections: [additionalSection], pagination: TestData.samplePagination)
        mockUseCase.mockResponse = moreResponse
        
        // When
        await sut.loadMoreSections()
        
        // Then
        XCTAssertEqual(sut.sections.count, 2)
        XCTAssertEqual(sut.paginationState, .loaded)
    }
    
    func testShouldLoadMore_LastSection() {
        // Given
        sut.sections = [TestData.sampleHomeSection]
        
        // When
        let shouldLoad = sut.shouldLoadMore(for: TestData.sampleHomeSection)
        
        // Then - Should not load more without pagination info
        XCTAssertFalse(shouldLoad)
    }
    
    func testComputedProperties() {
        // Given
        sut.sections = [TestData.sampleHomeSection]
        
        // Then
        XCTAssertEqual(sut.totalSections, 1)
        XCTAssertFalse(sut.isEmpty)
        XCTAssertFalse(sut.hasError)
    }
}
