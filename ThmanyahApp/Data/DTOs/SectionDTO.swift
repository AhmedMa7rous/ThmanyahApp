//
//  SectionDTO.swift
//  ThmanyahApp
//
//  Created by Ahmed Mahrous on 18/08/2025.
//

import Foundation

struct SectionDTO: Codable {
    let name: String
    let type: String
    let contentType: String
    let order: Int
    let content: [ContentDTO]
    
    enum CodingKeys: String, CodingKey {
        case name, type, order, content
        case contentType = "content_type"
    }
}
