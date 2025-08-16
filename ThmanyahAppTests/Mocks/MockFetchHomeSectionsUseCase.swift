//
//  MockFetchHomeSectionsUseCase.swift
//  ThmanyahApp
//
//  Created by Ahmed Mahrous on 16/08/2025.
//

import Foundation
@testable import ThmanyahApp

class MockFetchHomeSectionsUseCase: FetchHomeSectionsUseCaseProtocol {
    var mockResponse: HomeAPIResponse?
    var mockError: Error?
    var executeCalled = false
    var lastPage: Int?
    var isRefreshCalled = false
    
    func execute(page: Int, isRefresh: Bool) async throws -> HomeAPIResponse {
        executeCalled = true
        lastPage = page
        isRefreshCalled = isRefresh
        
        if let error = mockError {
            throw error
        }
        
        return mockResponse ?? TestData.sampleHomeAPIResponse
    }
    
    func reset() {
        mockResponse = nil
        mockError = nil
        executeCalled = false
        lastPage = nil
        isRefreshCalled = false
    }
}
