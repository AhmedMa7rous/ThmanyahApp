//
//  MockHomeRepository.swift
//  ThmanyahApp
//
//  Created by Ahmed Mahrous on 16/08/2025.
//

import Foundation
@testable import ThmanyahApp

class MockHomeRepository: HomeRepositoryProtocol {
    typealias DataType = HomeAPIResponse
    
    var mockResponse: HomeAPIResponse?
    var mockError: Error?
    var fetchHomeSectionsCalled = false
    var lastPage: Int?
    
    func fetchHomeSections(page: Int) async throws -> HomeAPIResponse {
        fetchHomeSectionsCalled = true
        lastPage = page
        
        if let error = mockError {
            throw error
        }
        
        return mockResponse ?? TestData.sampleHomeAPIResponse
    }
    
    func handleNetworkError(_ error: Error) -> Error {
        return error
    }
    
    func reset() {
        mockResponse = nil
        mockError = nil
        fetchHomeSectionsCalled = false
        lastPage = nil
    }
}
