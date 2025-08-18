//
//  PaginationState.swift
//  ThmanyahApp
//
//  Created by Ahmed Mahrous on 15/08/2025.
//

import Foundation

enum PaginationState: Equatable {
    case idle
    case loading
    case loadingMore
    case refreshing
    case loaded
    case error(String)
    
    var isLoading: Bool {
        switch self {
        case .loading, .loadingMore, .refreshing:
            return true
        default:
            return false
        }
    }
    
    var canLoadMore: Bool {
        switch self {
        case .loaded:
            return true
        default:
            return false
        }
    }
    
    var isInitialLoading: Bool {
        switch self {
        case .loading:
            return true
        default:
            return false
        }
    }
    
    var isLoadingMore: Bool {
        switch self {
        case .loadingMore:
            return true
        default:
            return false
        }
    }
    
    var isRefreshing: Bool {
        switch self {
        case .refreshing:
            return true
        default:
            return false
        }
    }
    
    var errorMessage: String? {
        switch self {
        case .error(let message):
            return message
        default:
            return nil
        }
    }
}
