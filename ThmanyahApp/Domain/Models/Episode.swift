//
//  Episode.swift
//  ThmanyahApp
//
//  Created by Ahmed Mahrous on 17/08/2025.
//

import Foundation

struct Episode: ContentProtocol, Codable {
    let id: String
    let name: String
    let podcastName: String
    let description: String
    let avatarUrl: String
    let duration: Int
    let releaseDate: Date
    let audioUrl: String
    let score: Double
    
    var contentType: ContentType { .episode }
    
    var formattedDuration: String {
        let hours = duration / 3600
        let minutes = (duration % 3600) / 60
        if hours > 0 {
            return "\(hours)س \(minutes)د"
        } else {
            return "\(minutes)د"
        }
    }
    
    var formattedReleaseDate: String {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "ar")
        formatter.dateStyle = .medium
        return formatter.string(from: releaseDate)
    }
}
