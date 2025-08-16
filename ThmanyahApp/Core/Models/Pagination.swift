//
//  Pagination.swift
//  ThmanyahApp
//
//  Created by Ahmed Mahrous on 15/08/2025.
//

import Foundation

struct Pagination: Codable {
    let nextPage: String?
    let totalPages: Int?
    let currentPage: Int?
    let hasNextPage: Bool
    let hasPreviousPage: Bool
    
    enum CodingKeys: String, CodingKey {
        case nextPage = "next_page"
        case totalPages = "total_pages"
        case currentPage = "current_page"
        case hasNextPage = "has_next_page"
        case hasPreviousPage = "has_previous_page"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        nextPage = try container.decodeIfPresent(String.self, forKey: .nextPage)
        totalPages = try container.decodeIfPresent(Int.self, forKey: .totalPages)
        currentPage = try container.decodeIfPresent(Int.self, forKey: .currentPage) ?? 1
        hasNextPage = nextPage != nil
        hasPreviousPage = (currentPage ?? 1) > 1
    }
    
    init(nextPage: String? = nil, totalPages: Int? = nil, currentPage: Int = 1) {
        self.nextPage = nextPage
        self.totalPages = totalPages
        self.currentPage = currentPage
        self.hasNextPage = nextPage != nil
        self.hasPreviousPage = currentPage > 1
    }
}
