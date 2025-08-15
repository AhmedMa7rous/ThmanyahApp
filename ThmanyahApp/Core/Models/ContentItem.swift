//
//  ContentItem.swift
//  ThmanyahApp
//
//  Created by Ahmed Mahrous on 15/08/2025.
//

import Foundation

struct ContentItem: Codable, Identifiable {
    let name: String
    let description: String?
    let avatarURL: String?
    let duration: Int?
    let language: String?
    let score: Double?
    
    let podcastId: String?
    let episodeCount: Int?
    let priority: Int?
    let popularityScore: Int?
    
    let episodeId: String?
    let seasonNumber: Int?
    let episodeType: String?
    let podcastName: String?
    let authorName: String?
    let number: Int?
    let audioURL: String?
    let separatedAudioURL: String?
    let releaseDate: String?
    let chapters: [Chapter]?
    let podcastPopularityScore: Int?
    let podcastPriority: Int?
    
    let audiobookId: String?
    
    let articleId: String?
    
    enum CodingKeys: String, CodingKey {
        case name, description, duration, language, score
        case avatarURL = "avatar_url"
        case podcastId = "podcast_id"
        case episodeCount = "episode_count"
        case priority, popularityScore
        case episodeId = "episode_id"
        case seasonNumber = "season_number"
        case episodeType = "episode_type"
        case podcastName = "podcast_name"
        case authorName = "author_name"
        case number
        case audioURL = "audio_url"
        case separatedAudioURL = "separated_audio_url"
        case releaseDate = "release_date"
        case chapters
        case podcastPopularityScore, podcastPriority
        case audiobookId = "audiobook_id"
        case articleId = "article_id"
    }
    
    // Generate ID using content type
    var id: String {
        if let podcastId = podcastId {
            return "podcast_\(podcastId)"
        } else if let episodeId = episodeId {
            return "episode_\(episodeId)"
        } else if let audiobookId = audiobookId {
            return "audiobook_\(audiobookId)"
        } else if let articleId = articleId {
            return "article_\(articleId)"
        } else {
            return UUID().uuidString
        }
    }
    
    var subtitle: String? {
        if let authorName = authorName, !authorName.isEmpty {
            return authorName
        } else if let podcastName = podcastName {
            return podcastName
        }
        return nil
    }
    
    var imageURL: String? {
        return avatarURL
    }
    
    var formattedDuration: String? {
        guard let duration = duration else { return nil }
        
        let hours = duration / 3600
        let minutes = (duration % 3600) / 60
        
        if hours > 0 {
            return "\(hours)h \(minutes)m"
        } else {
            return "\(minutes)m"
        }
    }
    
    var playCount: String? {
        if let episodeCount = episodeCount {
            return "\(episodeCount) episodes"
        }
        return nil
    }
    
    var formattedReleaseDate: String? {
        guard let releaseDate = releaseDate else { return nil }
        
        let formatter = ISO8601DateFormatter()
        guard let date = formatter.date(from: releaseDate) else { return nil }
        
        let displayFormatter = DateFormatter()
        displayFormatter.dateStyle = .medium
        return displayFormatter.string(from: date)
    }
}
