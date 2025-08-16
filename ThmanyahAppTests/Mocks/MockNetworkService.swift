//
//  MockNetworkService.swift
//  ThmanyahApp
//
//  Created by Ahmed Mahrous on 16/08/2025.
//

import Foundation
@testable import ThmanyahApp

class MockNetworkService: NetworkServiceProtocol {
    var mockResponse: Any?
    var mockError: Error?
    var requestCalled = false
    var lastEndpoint: APIEndpoint?
    
    func request<T: Codable>(_ endpoint: APIEndpoint) async throws -> T {
        requestCalled = true
        lastEndpoint = endpoint
        
        if let error = mockError {
            throw error
        }
        
        guard let response = mockResponse as? T else {
            throw NetworkError.decodingError("Mock response type mismatch")
        }
        
        return response
    }
    
    func reset() {
        mockResponse = nil
        mockError = nil
        requestCalled = false
        lastEndpoint = nil
    }
}
