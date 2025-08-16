//
//  HomeViewModel.swift
//  ThmanyahApp
//
//  Created by Ahmed Mahrous on 16/08/2025.
//

import Foundation
import SwiftUI

@MainActor
class HomeViewModel: ObservableObject {
    @Published var sections: [HomeSection] = []
    @Published var paginationState: PaginationState = .idle
    @Published var errorMessage: String?
    
    private let fetchHomeSectionsUseCase: FetchHomeSectionsUseCaseProtocol
    private var currentPage = 1
    private var pagination: Pagination?
    
    private var canLoadMore: Bool {
        pagination?.hasNextPage ?? false
    }
    
    init(fetchHomeSectionsUseCase: FetchHomeSectionsUseCaseProtocol) {
        self.fetchHomeSectionsUseCase = fetchHomeSectionsUseCase
    }
    
    func loadHomeSections() async {
        guard paginationState != .loading else { return }
        
        print("🏠 HomeViewModel: Loading sections")
        paginationState = .loading
        errorMessage = nil
        currentPage = 1
        
        do {
            let response = try await fetchHomeSectionsUseCase.execute(page: currentPage, isRefresh: false)
            sections = response.sections
            pagination = response.pagination
            paginationState = .loaded
            print("✅ HomeViewModel: Loaded \(sections.count) sections")
        } catch {
            errorMessage = error.localizedDescription
            paginationState = .error(error.localizedDescription)
            print("❌ HomeViewModel: Failed to load sections - \(error.localizedDescription)")
        }
    }
    
    func refresh() async {
        guard paginationState != .refreshing else { return }
        
        print("🔄 HomeViewModel: Refreshing sections")
        paginationState = .refreshing
        errorMessage = nil
        currentPage = 1
        
        do {
            let response = try await fetchHomeSectionsUseCase.execute(page: currentPage, isRefresh: true)
            sections = response.sections
            pagination = response.pagination
            paginationState = .loaded
            print("✅ HomeViewModel: Refreshed \(sections.count) sections")
        } catch {
            errorMessage = error.localizedDescription
            paginationState = .error(error.localizedDescription)
            print("❌ HomeViewModel: Failed to refresh - \(error)")
        }
    }
    
    func loadMoreSections() async {
        guard canLoadMore && paginationState.canLoadMore else {
            print("⚠️ HomeViewModel: Cannot load more - canLoadMore: \(canLoadMore), state: \(paginationState)")
            return
        }
        
        print("📄 HomeViewModel: Loading more sections - page \(currentPage + 1)")
        paginationState = .loadingMore
        currentPage += 1
        
        do {
            let response = try await fetchHomeSectionsUseCase.execute(page: currentPage, isRefresh: false)
            
            // Append new sections, avoiding duplicates
            let newSections = response.sections.filter { newSection in
                !sections.contains { existingSection in
                    existingSection.id == newSection.id
                }
            }
            
            sections.append(contentsOf: newSections)
            pagination = response.pagination
            paginationState = .loaded
            print("✅ HomeViewModel: Loaded \(newSections.count) more sections")
        } catch {
            currentPage -= 1 // Revert page increment on error
            errorMessage = error.localizedDescription
            paginationState = .error(error.localizedDescription)
            print("❌ HomeViewModel: Failed to load more - \(error)")
        }
    }
    
    func shouldLoadMore(for section: HomeSection) -> Bool {
        guard let lastSection = sections.last else { return false }
        let shouldLoad = section.id == lastSection.id && canLoadMore && paginationState.canLoadMore
        
        if shouldLoad {
            print("🎯 HomeViewModel: Should load more for section: \(section.name)")
        }
        
        return shouldLoad
    }
    
    func retryLastOperation() async {
        switch paginationState {
        case .error:
            if currentPage == 1 {
                await loadHomeSections()
            } else {
                await loadMoreSections()
            }
        default:
            await loadHomeSections()
        }
    }
    
    // MARK: - Computed Properties
    var isLoading: Bool {
        return paginationState.isInitialLoading
    }
    
    var isLoadingMore: Bool {
        return paginationState.isLoadingMore
    }
    
    var isRefreshing: Bool {
        return paginationState.isRefreshing
    }
    
    var hasError: Bool {
        return paginationState.errorMessage != nil
    }
    
    var isEmpty: Bool {
        return sections.isEmpty
    }
    
    var totalSections: Int {
        return sections.count
    }
    
    var canRefresh: Bool {
        return !paginationState.isLoading
    }
}
