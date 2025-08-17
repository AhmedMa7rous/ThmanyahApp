//
//  HomeViewModel.swift
//  ThmanyahApp
//
//  Created by Ahmed Mahrous on 18/08/2025.
//

import SwiftUI
import Combine

@MainActor
final class HomeViewModel: ObservableObject {
    @Published var sections: [HomeSection] = []
    @Published var isLoading = false
    @Published var isLoadingMore = false
    @Published var error: NetworkError?
    @Published var canLoadMore = true
    
    private let fetchHomeSectionsUseCase: FetchHomeSectionsUseCaseProtocol
    private var currentPage = 1
    private var totalPages = 1
    
    init(fetchHomeSectionsUseCase: FetchHomeSectionsUseCaseProtocol) {
        self.fetchHomeSectionsUseCase = fetchHomeSectionsUseCase
    }
    
    func loadInitialData() async {
        guard !isLoading else { return }
        
        isLoading = true
        error = nil
        currentPage = 1
        sections = []
        
        do {
            let result = try await fetchHomeSectionsUseCase.execute(page: currentPage)
            sections = result.sections
            totalPages = result.pagination.totalPages
            canLoadMore = result.pagination.hasNextPage
            
            print("✅ Loaded \(sections.count) sections, page \(currentPage)/\(totalPages)")
        } catch let networkError as NetworkError {
            self.error = networkError
            print("❌ Home loading error: \(networkError.localizedDescription)")
        } catch {
            self.error = NetworkError.networkError(error.localizedDescription)
            print("❌ Unknown home loading error: \(error)")
        }
        
        isLoading = false
    }
    
    func loadMore() async {
        guard !isLoading, !isLoadingMore, canLoadMore, currentPage < totalPages else { return }
        
        isLoadingMore = true
        currentPage += 1
        
        do {
            let result = try await fetchHomeSectionsUseCase.execute(page: currentPage)
            sections.append(contentsOf: result.sections)
            canLoadMore = result.pagination.hasNextPage
            
            print("✅ Loaded more sections, page \(currentPage)/\(totalPages)")
        } catch let networkError as NetworkError {
            currentPage -= 1 // Revert page increment on error
            self.error = networkError
            print("❌ Load more error: \(networkError.localizedDescription)")
        } catch {
            currentPage -= 1
            self.error = NetworkError.networkError(error.localizedDescription)
            print("❌ Unknown load more error: \(error)")
        }
        
        isLoadingMore = false
    }
    
    func refresh() async {
        await loadInitialData()
    }
    
    func clearError() {
        error = nil
    }
}
