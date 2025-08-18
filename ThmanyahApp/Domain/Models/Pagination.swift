//
//  Pagination.swift
//  ThmanyahApp
//
//  Created by Ahmed Mahrous on 15/08/2025.
//

import Foundation

struct Pagination: Equatable {
    let nextPage: String?
    let totalPages: Int
    let currentPage: Int
    let hasNextPage: Bool
    let hasPreviousPage: Bool
    
    init(nextPage: String?, totalPages: Int, currentPage: Int) {
        self.nextPage = nextPage
        self.totalPages = totalPages
        self.currentPage = currentPage
        self.hasNextPage = currentPage < totalPages
        self.hasPreviousPage = currentPage > 1
    }
    
    var isFirstPage: Bool {
        return currentPage == 1
    }
    
    var isLastPage: Bool {
        return currentPage >= totalPages
    }
}
