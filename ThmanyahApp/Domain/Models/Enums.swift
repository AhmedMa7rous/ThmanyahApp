//
//  Enums.swift
//  ThmanyahApp
//
//  Created by Ahmed Mahrous on 15/08/2025.
//

import Foundation

enum SectionType: String, CaseIterable, Equatable, Codable {
    case square = "square"
    case twoLinesGrid = "2_lines_grid"
    case bigSquare = "big_square"
    case queue = "queue"
    
    var columns: Int {
        switch self {
        case .square: return 3
        case .twoLinesGrid: return 2
        case .bigSquare: return 2
        case .queue: return 1
        }
    }
    
    var displayName: String {
        switch self {
        case .square: return "مربعات"
        case .twoLinesGrid: return "شبكة خطين"
        case .bigSquare: return "مربعات كبيرة"
        case .queue: return "قائمة"
        }
    }
}

enum ContentType: String, CaseIterable, Equatable, Codable {
    case podcast = "podcast"
    case episode = "episode"
    case audioBook = "audio_book"
    case audioArticle = "audio_article"
    
    var displayName: String {
        switch self {
        case .podcast: return "بودكاست"
        case .episode: return "حلقة"
        case .audioBook: return "كتاب صوتي"
        case .audioArticle: return "مقال صوتي"
        }
    }
}

enum ValidationError: LocalizedError {
    case invalidPage
    case emptyQuery
    
    var errorDescription: String? {
        switch self {
        case .invalidPage:
            return "رقم الصفحة غير صحيح"
        case .emptyQuery:
            return "لا يمكن أن يكون البحث فارغاً"
        }
    }
}

//enum SearchError: Error, LocalizedError {
//    case queryTooShort
//    case invalidCharacters
//
//    var errorDescription: String? {
//        switch self {
//        case .queryTooShort:
//            return "Search query must be at least 2 characters"
//        case .invalidCharacters:
//            return "Search query contains invalid characters"
//        }
//    }
//}
