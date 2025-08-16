//
//  SearchRepository.swift
//  ThmanyahApp
//
//  Created by Ahmed Mahrous on 16/08/2025.
//

import Foundation

protocol SearchRepositoryProtocol: BaseRepositoryProtocol {
    func search(query: String, page: Int) async throws -> SearchResponse
}

class SearchRepository: SearchRepositoryProtocol {
    typealias DataType = SearchResponse
    
    private let networkService: NetworkServiceProtocol
    
    init(networkService: NetworkServiceProtocol = NetworkService()) {
        self.networkService = networkService
    }
    
    func search(query: String, page: Int = 1) async throws -> SearchResponse {
        do {
            print("🔍 Searching for: '\(query)' on page: \(page)")
            let response: SearchResponse = try await networkService.request(.search(query: query, page: page))
            print("✅ Found \(response.resultCount) results")
            return response
        } catch {
            print("❌ Search failed: \(error)")
            throw handleNetworkError(error)
        }
    }
}
