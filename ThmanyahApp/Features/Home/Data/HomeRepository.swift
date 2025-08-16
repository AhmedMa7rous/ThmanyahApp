//
//  HomeRepository.swift
//  ThmanyahApp
//
//  Created by Ahmed Mahrous on 16/08/2025.
//

import Foundation

protocol HomeRepositoryProtocol: BaseRepositoryProtocol {
    func fetchHomeSections(page: Int) async throws -> HomeAPIResponse
}

class HomeRepository: HomeRepositoryProtocol {
    typealias DataType = HomeAPIResponse
    
    private let networkService: NetworkServiceProtocol
    
    init(networkService: NetworkServiceProtocol = NetworkService()) {
        self.networkService = networkService
    }
    
    func fetchHomeSections(page: Int = 1) async throws -> HomeAPIResponse {
        do {
            print("🏠 Fetching home sections for page: \(page)")
            let response: HomeAPIResponse = try await networkService.request(.homeSections(page: page))
            print("✅ Successfully fetched \(response.sectionCount) sections")
            return response
        } catch {
            print("❌ Failed to fetch home sections: \(error)")
            throw handleNetworkError(error)
        }
    }
}
