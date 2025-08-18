//
//  SearchResponseDTO.swift
//  ThmanyahApp
//
//  Created by Ahmed Mahrous on 18/08/2025.
//

import Foundation

struct SearchResponseDTO: Codable {
    let sections: [SearchSectionDTO]
}

struct SearchSectionDTO: Codable {
    let name: String
    let type: String
    let contentType: String
    let order: String
    let content: [SearchContentDTO]
    
    enum CodingKeys: String, CodingKey {
        case name, type, order, content
        case contentType = "content_type"
    }
}

struct SearchContentDTO: Codable {
    let name: String?
    let avatarUrl: String?
    let duration: String?
    let score: String?
    let podcastId: String?
    let description: String?
    let episodeCount: String?
    let language: String?
    let priority: String?
    let popularityScore: String?
    
    // Episode
    let episodeId: String?
    let podcastName: String?
    let audioUrl: String?
    let releaseDate: String?
    
    // AudioBook
    let audiobookId: String?
    let authorName: String?
    
    // AudioArticle
    let articleId: String?
    
    enum CodingKeys: String, CodingKey {
        case name, description, duration, language, priority, popularityScore, score
        case avatarUrl = "avatar_url"
        case podcastId = "podcast_id"
        case episodeCount = "episode_count"
        case episodeId = "episode_id"
        case podcastName = "podcast_name"
        case audioUrl = "audio_url"
        case releaseDate = "release_date"
        case audiobookId = "audiobook_id"
        case authorName = "author_name"
        case articleId = "article_id"
    }
}
