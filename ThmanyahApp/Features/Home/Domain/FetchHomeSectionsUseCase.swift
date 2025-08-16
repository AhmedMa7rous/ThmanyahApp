//
//  FetchHomeSectionsUseCase.swift
//  ThmanyahApp
//
//  Created by Ahmed Mahrous on 16/08/2025.
//

import Foundation

protocol FetchHomeSectionsUseCaseProtocol {
    func execute(page: Int, isRefresh: Bool) async throws -> HomeAPIResponse
}

class FetchHomeSectionsUseCase: FetchHomeSectionsUseCaseProtocol {
    private let repository: any HomeRepositoryProtocol
    
    init(repository: any HomeRepositoryProtocol) {
        self.repository = repository
    }
    
    func execute(page: Int = 1, isRefresh: Bool = false) async throws -> HomeAPIResponse {
        print("🎯 Executing FetchHomeSections UseCase - Page: \(page), Refresh: \(isRefresh)")
        
        do {
            let response = try await repository.fetchHomeSections(page: page)
            
            // Sort sections by order
            let sortedSections = response.sections.sorted { $0.order < $1.order }
            
            // Filter out empty sections if needed
            let filteredSections = sortedSections.filter { !$0.isEmpty }
            
            let processedResponse = HomeAPIResponse(
                sections: filteredSections,
                pagination: response.pagination
            )
            
            print("✅ UseCase processed \(processedResponse.sectionCount) sections")
            return processedResponse
            
        } catch {
            print("❌ UseCase failed: \(error)")
            throw error
        }
    }
}
