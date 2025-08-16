//
//  SearchContentUseCase.swift
//  ThmanyahApp
//
//  Created by Ahmed Mahrous on 16/08/2025.
//

import Foundation

protocol SearchContentUseCaseProtocol {
    func execute(query: String, page: Int) async throws -> SearchResponse
}

class SearchContentUseCase: SearchContentUseCaseProtocol {
    private let repository: any SearchRepositoryProtocol
    
    init(repository: any SearchRepositoryProtocol) {
        self.repository = repository
    }
    
    func execute(query: String, page: Int = 1) async throws -> SearchResponse {
        let trimmedQuery = query.trimmed()
        
        print("🎯 Executing SearchContent UseCase - Query: '\(trimmedQuery)', Page: \(page)")
        
        guard trimmedQuery.isNotEmpty else {
            print("⚠️ Empty query provided")
            return SearchResponse(results: [], totalCount: 0, pagination: nil)
        }
        
        // Validate query length
        guard trimmedQuery.count >= 2 else {
            print("⚠️ Query too short: \(trimmedQuery.count) characters")
            throw SearchError.queryTooShort
        }
        
        do {
            let response = try await repository.search(query: trimmedQuery, page: page)
            
            // Remove duplicates and sort by score
            let uniqueResults = response.results.removingDuplicates()
            let sortedResults = uniqueResults.sorted { ($0.score ?? 0) > ($1.score ?? 0) }
            
            let processedResponse = SearchResponse(
                results: sortedResults,
                totalCount: response.totalCount,
                pagination: response.pagination
            )
            
            print("✅ UseCase processed \(processedResponse.resultCount) results")
            return processedResponse
            
        } catch {
            print("❌ Search UseCase failed: \(error)")
            throw error
        }
    }
}

enum SearchError: Error, LocalizedError {
    case queryTooShort
    case invalidCharacters
    
    var errorDescription: String? {
        switch self {
        case .queryTooShort:
            return "Search query must be at least 2 characters"
        case .invalidCharacters:
            return "Search query contains invalid characters"
        }
    }
}
