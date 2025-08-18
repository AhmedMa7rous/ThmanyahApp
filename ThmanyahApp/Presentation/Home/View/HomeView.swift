//
//  HomeView.swift
//  ThmanyahApp
//
//  Created by Ahmed Mahrous on 18/08/2025.
//

import SwiftUI

struct HomeView: View {
    @ObservedObject var viewModel: HomeViewModel
    
    var body: some View {
        ScrollView {
            LazyVStack(spacing: 24) {
                ForEach(viewModel.sections) { section in
                    SectionView(section: section)
                }
                
                if viewModel.canLoadMore && !viewModel.sections.isEmpty {
                    loadMoreView
                }
            }
            .padding(.horizontal, 16)
            .padding(.vertical, 12)
        }
        .refreshable {
            await viewModel.refresh()
        }
        .task {
            if viewModel.sections.isEmpty {
                await viewModel.loadInitialData()
            }
        }
        .overlay {
            if viewModel.isLoading && viewModel.sections.isEmpty {
                loadingView
            }
        }
        .overlay {
            if let error = viewModel.error, viewModel.sections.isEmpty {
                ErrorView(
                    error: error,
                    onRetry: {
                        viewModel.clearError()
                        Task {
                            await viewModel.loadInitialData()
                        }
                    }
                )
            }
        }
    }
    
    private var loadMoreView: some View {
        HStack {
            if viewModel.isLoadingMore {
                ProgressView()
                    .progressViewStyle(CircularProgressViewStyle(tint: .orange))
                    .scaleEffect(0.8)
                
                Text("جاري تحميل المزيد...")
                    .font(.custom(FontNames.IBMPlexSansArabicRegular, size: 14))
                    .foregroundColor(.gray)
            } else {
                Text("اسحب لأعلى لتحميل المزيد")
                    .font(.custom(FontNames.IBMPlexSansArabicRegular, size: 14))
                    .foregroundColor(.gray)
            }
        }
        .frame(height: 50)
        .onAppear {
            Task {
                await viewModel.loadMore()
            }
        }
    }
    
    private var loadingView: some View {
        VStack(spacing: 20) {
            ProgressView()
                .progressViewStyle(CircularProgressViewStyle(tint: .orange))
                .scaleEffect(1.5)
            
            Text("جاري التحميل...")
                .font(.custom(FontNames.IBMPlexSansArabicMedium, size: 16))
                .foregroundColor(.white)
        }
    }
}

#Preview {
    let networkService = NetworkService()
    let repository = ContentRepository(networkService: networkService)
    let useCase = FetchHomeSectionsUseCase(repository: repository)
    let viewModel = HomeViewModel(fetchHomeSectionsUseCase: useCase)
    
    return HomeView(viewModel: viewModel)
        .background(Color.black)
}
