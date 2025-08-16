//
//  HomeSection.swift
//  ThmanyahApp
//
//  Created by Ahmed Mahrous on 15/08/2025.
//

import Foundation

struct HomeSection: Codable, Identifiable {
    let name: String
    let type: SectionLayoutType
    let contentType: ContentType
    let order: Int
    let content: [ContentItem]
    
    enum CodingKeys: String, CodingKey {
        case name, type, order, content
        case contentType = "content_type"
    }
    
    var id: String {
        return "\(name.replacingOccurrences(of: " ", with: "_").lowercased())_\(order)"
    }
    
    var displayName: String {
        return name
    }
    
    var isEmpty: Bool {
        return content.isEmpty
    }
    
    var itemCount: Int {
        return content.count
    }
}
