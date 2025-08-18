//
//  Podcast.swift
//  ThmanyahApp
//
//  Created by Ahmed Mahrous on 17/08/2025.
//

import Foundation

struct Podcast: ContentProtocol, Codable {
    let id: String
    let name: String
    let description: String
    let avatarUrl: String
    let episodeCount: Int
    var duration: Int
    let language: String
    let priority: Int
    let popularityScore: Int
    let score: Double
    
    var contentType: ContentType { .podcast }
    
    var episodeCountText: String {
        return "\(episodeCount) حلقة"
    }
    
    var subtitle: String {
        return description.isEmpty ? episodeCountText : description
    }
}
