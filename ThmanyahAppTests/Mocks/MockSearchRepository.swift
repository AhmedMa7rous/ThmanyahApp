//
//  MockSearchRepository.swift
//  ThmanyahApp
//
//  Created by Ahmed Mahrous on 16/08/2025.
//

import Foundation
@testable import ThmanyahApp

class MockSearchRepository: SearchRepositoryProtocol {
    typealias DataType = SearchResponse
    
    var mockResponse: SearchResponse?
    var mockError: Error?
    var searchCalled = false
    var lastQuery: String?
    var lastPage: Int?
    
    func search(query: String, page: Int) async throws -> SearchResponse {
        searchCalled = true
        lastQuery = query
        lastPage = page
        
        if let error = mockError {
            throw error
        }
        
        return mockResponse ?? TestData.sampleSearchResponse
    }
    
    func handleNetworkError(_ error: Error) -> Error {
        return error
    }
    
    func reset() {
        mockResponse = nil
        mockError = nil
        searchCalled = false
        lastQuery = nil
        lastPage = nil
    }
}
