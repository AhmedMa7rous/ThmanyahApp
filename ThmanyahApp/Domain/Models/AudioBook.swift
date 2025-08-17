//
//  AudioBook.swift
//  ThmanyahApp
//
//  Created by Ahmed Mahrous on 17/08/2025.
//

import Foundation

struct AudioBook: ContentProtocol, Codable {
    let id: String
    let name: String
    let authorName: String
    let description: String
    let avatarUrl: String
    let duration: Int
    let language: String
    let releaseDate: Date
    let score: Double
    
    var contentType: ContentType { .audioBook }
    
    var formattedDuration: String {
        let hours = duration / 3600
        let minutes = (duration % 3600) / 60
        if hours > 0 {
            return "\(hours)س \(minutes)د"
        } else {
            return "\(minutes)د"
        }
    }
    
    var authorText: String {
        return "بقلم \(authorName)"
    }
}
