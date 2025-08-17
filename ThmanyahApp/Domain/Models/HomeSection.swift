//
//  HomeSection.swift
//  ThmanyahApp
//
//  Created by Ahmed Mahrous on 15/08/2025.
//

import Foundation

struct HomeSection: Identifiable, Equatable, Hashable {
    let id = UUID()
    let name: String
    let type: SectionType
    let contentType: ContentType
    let order: Int
    let content: [ContentItem]
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}
