//
//  FetchHomeSectionsUseCase.swift
//  ThmanyahApp
//
//  Created by Ahmed Mahrous on 16/08/2025.
//

import Foundation

protocol FetchHomeSectionsUseCaseProtocol {
    func execute(page: Int) async throws -> (sections: [HomeSection], pagination: Pagination)
}

final class FetchHomeSectionsUseCase: FetchHomeSectionsUseCaseProtocol {
    private let repository: ContentRepositoryProtocol
    
    init(repository: ContentRepositoryProtocol) {
        self.repository = repository
    }
    
    func execute(page: Int = 1) async throws -> (sections: [HomeSection], pagination: Pagination) {
        guard page > 0 else {
            throw ValidationError.invalidPage
        }
        
        return try await repository.fetchHomeSections(page: page)
    }
}
