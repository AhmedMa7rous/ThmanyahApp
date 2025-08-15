//
//  HomeAPIResponse.swift
//  ThmanyahApp
//
//  Created by Ahmed Mahrous on 15/08/2025.
//

import Foundation

struct HomeAPIResponse: Codable {
    let sections: [HomeSection]
    let pagination: Pagination?
    
    var isEmpty: Bool {
        return sections.isEmpty
    }
    
    var sectionCount: Int {
        return sections.count
    }
    
    var totalItems: Int {
        return sections.reduce(0) { $0 + $1.itemCount }
    }
}
