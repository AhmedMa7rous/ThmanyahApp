//
//  SearchView.swift
//  ThmanyahApp
//
//  Created by Ahmed Mahrous on 18/08/2025.
//

import SwiftUI

struct SearchView: View {
    @ObservedObject var viewModel: SearchViewModel
    @FocusState private var isSearchFocused: Bool
    
    var body: some View {
        VStack(spacing: 0) {
            SearchBar(
                text: $viewModel.searchText,
                isSearching: $viewModel.isSearching,
                onClear: viewModel.clearSearch
            )
            .focused($isSearchFocused)
            .onChange(of: viewModel.searchText) { _ in
                viewModel.search()
            }
            
            contentView
        }
        .onAppear {
            isSearchFocused = true
        }
    }
    
    @ViewBuilder
    private var contentView: some View {
        if viewModel.isSearching {
            loadingView
        } else if let error = viewModel.error {
            ErrorView(
                error: error,
                onRetry: {
                    viewModel.clearError()
                    viewModel.search()
                }
            )
        } else if viewModel.sections.isEmpty && viewModel.hasSearched {
            emptyStateView
        } else if !viewModel.sections.isEmpty {
            resultsView
        } else {
            initialStateView
        }
    }
    
    private var resultsView: some View {
        ScrollView {
            LazyVStack(spacing: 24) {
                ForEach(viewModel.sections) { section in
                    SectionView(section: section)
                }
            }
            .padding(.horizontal, 16)
            .padding(.vertical, 12)
        }
    }
    
    private var loadingView: some View {
        VStack(spacing: 20) {
            Spacer()
            ProgressView()
                .progressViewStyle(CircularProgressViewStyle(tint: .orange))
                .scaleEffect(1.5)
            
            Text("جاري البحث...")
                .font(.custom(FontNames.IBMPlexSansArabicMedium, size: 16))
                .foregroundColor(.white)
            Spacer()
        }
    }
    
    private var emptyStateView: some View {
        VStack(spacing: 24) {
            Spacer()
            
            Image(systemName: "magnifyingglass")
                .font(.system(size: 60))
                .foregroundColor(.gray)
            
            VStack(spacing: 8) {
                Text("لا توجد نتائج")
                    .font(.custom(FontNames.IBMPlexSansArabicBold, size: 20))
                    .foregroundColor(.white)
                
                Text("جرب البحث بكلمات مختلفة أو تحقق من الإملاء")
                    .font(.custom(FontNames.IBMPlexSansArabicRegular, size: 14))
                    .foregroundColor(.gray)
                    .multilineTextAlignment(.center)
            }
            
            Spacer()
        }
        .padding(.horizontal, 40)
    }
    
    private var initialStateView: some View {
        VStack(spacing: 24) {
            Spacer()
            
            Image(systemName: "magnifyingglass.circle")
                .font(.system(size: 80))
                .foregroundColor(.orange)
            
            VStack(spacing: 12) {
                Text("ابحث عن المحتوى المفضل لديك")
                    .font(.custom(FontNames.IBMPlexSansArabicBold, size: 20))
                    .foregroundColor(.white)
                    .multilineTextAlignment(.center)
                
                Text("ابدأ بكتابة اسم البودكاست، الحلقة، أو الكاتب")
                    .font(.custom(FontNames.IBMPlexSansArabicRegular, size: 14))
                    .foregroundColor(.gray)
                    .multilineTextAlignment(.center)
            }
            
            if !viewModel.searchHistory.isEmpty {
                searchHistoryView
            }
            
            Spacer()
        }
        .padding(.horizontal, 40)
    }
    
    private var searchHistoryView: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack {
                Text("عمليات البحث الأخيرة")
                    .font(.custom(FontNames.IBMPlexSansArabicMedium, size: 16))
                    .foregroundColor(.white)
                
                Spacer()
                
                Button("مسح الكل") {
                    viewModel.clearSearchHistory()
                }
                .font(.custom(FontNames.IBMPlexSansArabicRegular, size: 14))
                .foregroundColor(.orange)
            }
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 8) {
                    ForEach(viewModel.searchHistory, id: \.self) { query in
                        Button(action: {
                            viewModel.selectSearchHistory(query)
                        }) {
                            Text(query)
                                .font(.custom(FontNames.IBMPlexSansArabicRegular, size: 14))
                                .foregroundColor(.white)
                                .padding(.horizontal, 12)
                                .padding(.vertical, 6)
                                .background(Color.gray.opacity(0.3))
                                .cornerRadius(16)
                        }
                    }
                }
                .padding(.horizontal, 1)
            }
        }
        .padding(.top, 20)
    }
}

#Preview {
    let networkService = NetworkService()
    let repository = ContentRepository(networkService: networkService)
    let useCase = SearchContentUseCase(repository: repository)
    let viewModel = SearchViewModel(searchContentUseCase: useCase)
    
    return SearchView(viewModel: viewModel)
        .background(Color.black)
}
