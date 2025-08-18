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
    
    var authorText: String {
        return "بقلم \(authorName)"
    }
    
    var subtitle: String {
        return authorText
    }
    
    var metadata: String {
        return formattedDuration
    }
}
