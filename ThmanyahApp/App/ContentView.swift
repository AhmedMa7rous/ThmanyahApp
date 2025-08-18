//
//  ContentView.swift
//  ThmanyahApp
//
//  Created by Ahmed Mahrous on 14/08/2025.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var homeViewModel: HomeViewModel
    @StateObject private var searchViewModel: SearchViewModel
    @State private var showSearch = false
    
    init() {
        // Dependency injection setup
        let networkService = NetworkService()
        let repository = ContentRepository(networkService: networkService)
        let fetchUseCase = FetchHomeSectionsUseCase(repository: repository)
        let searchUseCase = SearchContentUseCase(repository: repository)
        
        _homeViewModel = StateObject(wrappedValue: HomeViewModel(fetchHomeSectionsUseCase: fetchUseCase))
        _searchViewModel = StateObject(wrappedValue: SearchViewModel(searchContentUseCase: searchUseCase))
    }
    
    var body: some View {
        NavigationView {
            ZStack {
                Color.black.ignoresSafeArea()
                
                if showSearch {
                    SearchView(viewModel: searchViewModel)
                        .onDisappear {
                            searchViewModel.clearSearch()
                        }
                } else {
                    HomeView(viewModel: homeViewModel)
                }
            }
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button(action: toggleSearch) {
                        Image(systemName: showSearch ? "xmark" : "magnifyingglass")
                            .foregroundColor(.white)
                            .font(.system(size: 18, weight: .medium))
                    }
                }
                
                ToolbarItem(placement: .principal) {
                    Text("مساء الخير")
                        .font(.custom(FontNames.IBMPlexSansArabicBold, size: 20))
                        .foregroundColor(.white)
                }
                
                ToolbarItem(placement: .navigationBarTrailing) {
                    HStack(spacing: 15) {
                        Button(action: {}) {
                            Image(systemName: "bell")
                                .foregroundColor(.white)
                                .font(.system(size: 18, weight: .medium))
                        }
                        
                        Button(action: {}) {
                            Image(systemName: "person.circle")
                                .foregroundColor(.white)
                                .font(.system(size: 18, weight: .medium))
                        }
                    }
                }
            }
        }
        .preferredColorScheme(.dark)
    }
    
    private func toggleSearch() {
        withAnimation(.easeInOut(duration: 0.3)) {
            showSearch.toggle()
        }
        
        if !showSearch {
            searchViewModel.clearSearch()
        }
    }
}

#Preview {
    ContentView()
}
