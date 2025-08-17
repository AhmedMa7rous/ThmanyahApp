//
//  SearchContentUseCase.swift
//  ThmanyahApp
//
//  Created by Ahmed Mahrous on 16/08/2025.
//

import Foundation

protocol SearchContentUseCaseProtocol {
    func execute(query: String, page: Int, limit: Int) async throws -> (sections: [HomeSection], pagination: Pagination)
}

final class SearchContentUseCase: SearchContentUseCaseProtocol {
    private let repository: ContentRepositoryProtocol
    
    init(repository: ContentRepositoryProtocol) {
        self.repository = repository
    }
    
    func execute(
        query: String,
        page: Int = 1,
        limit: Int = APIConstants.Pagination.defaultPageSize
    ) async throws -> (sections: [HomeSection], pagination: Pagination) {
        
        let trimmedQuery = query.trimmingCharacters(in: .whitespacesAndNewlines)
        
        guard !trimmedQuery.isEmpty else {
            throw ValidationError.emptyQuery
        }
        
        guard page > 0 else {
            throw ValidationError.invalidPage
        }
        
        return try await repository.searchContent(query: trimmedQuery, page: page, limit: limit)
    }
}
