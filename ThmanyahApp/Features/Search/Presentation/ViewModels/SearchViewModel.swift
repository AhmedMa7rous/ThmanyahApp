//
//  SearchViewModel.swift
//  ThmanyahApp
//
//  Created by Ahmed Mahrous on 16/08/2025.
//

import Foundation
import SwiftUI

@MainActor
class SearchViewModel: ObservableObject {
    @Published var searchText = ""
    @Published var searchResults: [ContentItem] = []
    @Published var paginationState: PaginationState = .idle
    @Published var errorMessage: String?
    @Published var totalCount: Int = 0
    
    private let searchUseCase: SearchContentUseCaseProtocol
    private var searchTask: Task<Void, Never>?
    private var currentPage = 1
    private var pagination: Pagination?
    private var currentQuery = ""
    
    private var canLoadMore: Bool {
        pagination?.hasNextPage ?? false
    }
    
    init(searchUseCase: SearchContentUseCaseProtocol) {
        self.searchUseCase = searchUseCase
    }
    
    func searchContent() {
        searchTask?.cancel()
        
        let trimmedQuery = searchText.trimmed()
        guard trimmedQuery.isNotEmpty else {
            clearResults()
            return
        }
        
        searchTask = Task {
            // Debounce for 200ms
            try? await Task.sleep(nanoseconds: 200_000_000)
            
            if !Task.isCancelled {
                await performNewSearch(query: trimmedQuery)
            }
        }
    }
    
    private func performNewSearch(query: String) async {
        print("🔍 SearchViewModel: Performing new search for '\(query)'")
        
        paginationState = .loading
        errorMessage = nil
        currentPage = 1
        currentQuery = query
        
        do {
            let response = try await searchUseCase.execute(query: query, page: currentPage)
            if !Task.isCancelled {
                searchResults = response.results
                totalCount = response.totalCount
                pagination = response.pagination
                paginationState = .loaded
                print("✅ SearchViewModel: Found \(response.resultCount) results")
            }
        } catch {
            if !Task.isCancelled {
                errorMessage = error.localizedDescription
                paginationState = .error(error.localizedDescription)
                print("❌ SearchViewModel: Search failed - \(error)")
            }
        }
    }
    
    func loadMoreResults() async {
        guard canLoadMore &&
              paginationState.canLoadMore &&
              currentQuery.isNotEmpty else {
            print("⚠️ SearchViewModel: Cannot load more results")
            return
        }
        
        print("📄 SearchViewModel: Loading more results - page \(currentPage + 1)")
        paginationState = .loadingMore
        currentPage += 1
        
        do {
            let response = try await searchUseCase.execute(query: currentQuery, page: currentPage)
            
            // Append new results, avoiding duplicates
            let newResults = response.results.filter { newResult in
                !searchResults.contains { existingResult in
                    existingResult.id == newResult.id
                }
            }
            
            searchResults.append(contentsOf: newResults)
            pagination = response.pagination
            paginationState = .loaded
            print("✅ SearchViewModel: Loaded \(newResults.count) more results")
        } catch {
            currentPage -= 1 // Revert page increment on error
            errorMessage = error.localizedDescription
            paginationState = .error(error.localizedDescription)
            print("❌ SearchViewModel: Failed to load more results - \(error)")
        }
    }
    
    func shouldLoadMore(for item: ContentItem) -> Bool {
        guard let lastItem = searchResults.last else { return false }
        let shouldLoad = item.id == lastItem.id && canLoadMore && paginationState.canLoadMore
        
        if shouldLoad {
            print("🎯 SearchViewModel: Should load more for item: \(item.name)")
        }
        
        return shouldLoad
    }
    
    func clearSearch() {
        print("🧹 SearchViewModel: Clearing search")
        searchTask?.cancel()
        clearResults()
        searchText = ""
        currentQuery = ""
    }
    
    private func clearResults() {
        searchResults = []
        totalCount = 0
        pagination = nil
        paginationState = .idle
        errorMessage = nil
        currentPage = 1
    }
    
    func retrySearch() async {
        if currentQuery.isNotEmpty {
            await performNewSearch(query: currentQuery)
        }
    }
    
    // MARK: - Computed Properties
    var isLoading: Bool {
        return paginationState.isInitialLoading
    }
    
    var isLoadingMore: Bool {
        return paginationState.isLoadingMore
    }
    
    var hasResults: Bool {
        return !searchResults.isEmpty
    }
    
    var hasError: Bool {
        return paginationState.errorMessage != nil
    }
    
    var isEmpty: Bool {
        return searchResults.isEmpty && currentQuery.isNotEmpty && !isLoading
    }
    
    var showEmptyState: Bool {
        return searchText.trimmed().isEmpty && !isLoading
    }
    
    var resultCount: Int {
        return searchResults.count
    }
    
    var formattedResultCount: String {
        if totalCount == 0 {
            return "No results"
        } else if totalCount == 1 {
            return "1 result"
        } else {
            return "\(totalCount) results"
        }
    }
}
