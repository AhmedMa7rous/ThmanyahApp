//
//  ContentRepository.swift
//  ThmanyahApp
//
//  Created by Ahmed Mahrous on 18/08/2025.
//

import Foundation

final class ContentRepository: ContentRepositoryProtocol {
    private let networkService: NetworkServiceProtocol
    
    init(networkService: NetworkServiceProtocol) {
        self.networkService = networkService
    }
    
    func fetchHomeSections(page: Int) async throws -> (sections: [HomeSection], pagination: Pagination) {
        let endpoint = APIEndpoint.homeSections(page: page)
        
        do {
            let response: HomeSectionsResponseDTO = try await networkService.request(endpoint)
            
            let sections = response.sections
                .map(ContentMapper.mapToSection)
                .sorted { $0.order < $1.order }
            
            let pagination = ContentMapper.mapToPagination(response.pagination, currentPage: page)
            
            print("✅ Fetched \(sections.count) sections for page \(page)")
            return (sections, pagination)
            
        } catch {
            print("❌ Failed to fetch home sections: \(error)")
            throw error
        }
    }
    
    func searchContent(query: String, page: Int, limit: Int) async throws -> (sections: [HomeSection], pagination: Pagination) {
        let endpoint = APIEndpoint.search(query: query, page: page, limit: limit)
        
        do {
            let response: SearchResponseDTO = try await networkService.request(endpoint)
            
            let sections = response.sections
                .map(ContentMapper.mapSearchToSection)
                .sorted { $0.order < $1.order }
            
            // Search API doesn't provide pagination, so create a mock one
            let pagination = Pagination(
                nextPage: nil,
                totalPages: 1,
                currentPage: 1
            )
            
            print("✅ Search found \(sections.count) sections for query: '\(query)'")
            return (sections, pagination)
            
        } catch {
            print("❌ Failed to search content: \(error)")
            throw error
        }
    }
}
