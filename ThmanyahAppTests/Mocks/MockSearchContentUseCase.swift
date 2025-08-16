//
//  MockSearchContentUseCase.swift
//  ThmanyahApp
//
//  Created by Ahmed Mahrous on 16/08/2025.
//

import Foundation
@testable import ThmanyahApp

class MockSearchContentUseCase: SearchContentUseCaseProtocol {
    var mockResponse: SearchResponse?
    var mockError: Error?
    var executeCalled = false
    var lastQuery: String?
    var lastPage: Int?
    
    func execute(query: String, page: Int) async throws -> SearchResponse {
        executeCalled = true
        lastQuery = query
        lastPage = page
        
        if let error = mockError {
            throw error
        }
        
        return mockResponse ?? TestData.sampleSearchResponse
    }
    
    func reset() {
        mockResponse = nil
        mockError = nil
        executeCalled = false
        lastQuery = nil
        lastPage = nil
    }
}
