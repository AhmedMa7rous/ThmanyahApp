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
    let duration: Int
    let language: String
    let priority: String
    let popularityScore: String
    let score: Double
    
    var contentType: ContentType { .podcast }
    
    var formattedDuration: String {
        let hours = duration / 3600
        let minutes = (duration % 3600) / 60
        if hours > 0 {
            return "\(hours)س \(minutes)د"
        } else {
            return "\(minutes)د"
        }
    }
    
    var episodeCountText: String {
        return "\(episodeCount) حلقة"
    }
}
