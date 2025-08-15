//
//  SearchResponse.swift
//  ThmanyahApp
//
//  Created by Ahmed Mahrous on 15/08/2025.
//

import Foundation

struct SearchResponse: Codable {
    let results: [ContentItem]
    let totalCount: Int
    let pagination: Pagination?
    
    enum CodingKeys: String, CodingKey {
        case results
        case totalCount = "total_count"
        case pagination
    }
    
    var isEmpty: Bool {
        return results.isEmpty
    }
    
    var hasResults: Bool {
        return !results.isEmpty
    }
    
    var resultCount: Int {
        return results.count
    }
}
