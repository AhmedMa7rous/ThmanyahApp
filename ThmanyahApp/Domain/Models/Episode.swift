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
    var duration: Int
    let releaseDate: Date
    let audioUrl: String
    let score: Double
    
    var contentType: ContentType { .episode }
    
    var formattedReleaseDate: String {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "ar")
        formatter.dateStyle = .medium
        return formatter.string(from: releaseDate)
    }
    
    var subtitle: String {
        return podcastName
    }
    
    var metadata: String {
        return formattedDuration
    }
}
