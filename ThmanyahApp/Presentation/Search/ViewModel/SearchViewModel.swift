//
//  SearchViewModel.swift
//  ThmanyahApp
//
//  Created by Ahmed Mahrous on 18/08/2025.
//

import SwiftUI
import Combine

@MainActor
final class SearchViewModel: ObservableObject {
    @Published var searchText = ""
    @Published var sections: [HomeSection] = []
    @Published var isSearching = false
    @Published var error: NetworkError?
    @Published var hasSearched = false
    @Published var searchHistory: [String] = []
    
    private let searchContentUseCase: SearchContentUseCaseProtocol
    private var searchTask: Task<Void, Never>?
    private let maxHistoryItems = 10
    
    init(searchContentUseCase: SearchContentUseCaseProtocol) {
        self.searchContentUseCase = searchContentUseCase
        loadSearchHistory()
    }
    
    func search() {
        searchTask?.cancel()
        
        let trimmedQuery = searchText.trimmingCharacters(in: .whitespacesAndNewlines)
        
        guard !trimmedQuery.isEmpty else {
            sections = []
            hasSearched = false
            return
        }
        
        searchTask = Task {
            try? await Task.sleep(nanoseconds: 300_000_000) // 300ms debounce
            
            guard !Task.isCancelled else { return }
            
            await performSearch(query: trimmedQuery)
        }
    }
    
    private func performSearch(query: String) async {
        isSearching = true
        error = nil
        hasSearched = true
        
        do {
            let result = try await searchContentUseCase.execute(
                query: query,
                page: 1,
                limit: APIConstants.Pagination.defaultPageSize
            )
            
            sections = result.sections
            
            if !sections.isEmpty {
                addToSearchHistory(query)
            }
            
            print("✅ Search completed for '\(query)': \(sections.count) sections found")
            
        } catch let networkError as NetworkError {
            self.error = networkError
            sections = []
            print("❌ Search error: \(networkError.localizedDescription)")
        } catch {
            self.error = NetworkError.networkError(error.localizedDescription)
            sections = []
            print("❌ Unknown search error: \(error)")
        }
        
        isSearching = false
    }
    
    func clearSearch() {
        searchText = ""
        sections = []
        hasSearched = false
        error = nil
        searchTask?.cancel()
    }
    
    func selectSearchHistory(_ query: String) {
        searchText = query
        search()
    }
    
    func clearSearchHistory() {
        searchHistory = []
        saveSearchHistory()
    }
    
    func clearError() {
        error = nil
    }
    
    // MARK: - Search History Management
    private func addToSearchHistory(_ query: String) {
        searchHistory.removeAll { $0.lowercased() == query.lowercased() }
        
        searchHistory.insert(query, at: 0)
        
        if searchHistory.count > maxHistoryItems {
            searchHistory = Array(searchHistory.prefix(maxHistoryItems))
        }
        
        saveSearchHistory()
    }
    
    private func loadSearchHistory() {
        searchHistory = UserDefaults.standard.stringArray(forKey: "SearchHistory") ?? []
    }
    
    private func saveSearchHistory() {
        UserDefaults.standard.set(searchHistory, forKey: "SearchHistory")
    }
}
