//
//  Enums.swift
//  ThmanyahApp
//
//  Created by Ahmed Mahrous on 15/08/2025.
//

import Foundation

enum ContentType: String, Codable {
    case podcast = "podcast"
    case episode = "episode"
    case audioBook = "audio_book"
    case audioArticle = "audio_article"
}

enum SectionLayoutType: String, Codable {
    case square
    case twoLinesGrid = "2_lines_grid"
    case bigSquare = "big_square"
    case queue
    
    var gridColumns: Int {
        switch self {
        case .square, .twoLinesGrid:
            return 2
        case .bigSquare, .queue:
            return 1
        }
    }
    
    var itemSpacing: CGFloat {
        switch self {
        case .square, .twoLinesGrid:
            return 12
        case .bigSquare:
            return 16
        case .queue:
            return 8
        }
    }
}

enum ItemLayout {
    case grid, horizontal, list, bigSquare
}
