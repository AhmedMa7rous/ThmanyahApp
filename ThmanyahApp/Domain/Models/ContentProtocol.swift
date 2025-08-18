//
//  ContentProtocol.swift
//  ThmanyahApp
//
//  Created by Ahmed Mahrous on 17/08/2025.
//

import Foundation

protocol ContentProtocol: Identifiable, Equatable, Hashable {
    var id: String { get }
    var name: String { get }
    var avatarUrl: String { get }
    var contentType: ContentType { get }
    var duration: Int { get }
    var score: Double { get }
}

extension ContentProtocol {
    static func == (lhs: Self, rhs: Self) -> Bool {
        return lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    var formattedDuration: String {
        let hours = duration / 3600
        let minutes = (duration % 3600) / 60
        if hours > 0 {
            return "\(hours)س \(minutes)د"
        } else {
            return "\(minutes)د"
        }
    }
    
    var contentIcon: String {
        switch contentType {
        case .podcast: return "mic.fill"
        case .episode: return "play.circle.fill"
        case .audioBook: return "book.fill"
        case .audioArticle: return "doc.text.fill"
        }
    }
}
