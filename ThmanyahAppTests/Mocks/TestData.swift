//
//  TestData.swift
//  ThmanyahApp
//
//  Created by Ahmed Mahrous on 16/08/2025.
//

import Foundation
@testable import ThmanyahApp

struct TestData {
    static let sampleContentItem = ContentItem(
        name: "Test Content",
        description: "Test description",
        avatarURL: "https://example.com/image.jpg",
        duration: 3600,
        language: "en",
        score: 100.0,
        podcastId: "123",
        episodeCount: 10,
        priority: 1,
        popularityScore: 9,
        episodeId: nil,
        seasonNumber: nil,
        episodeType: nil,
        podcastName: nil,
        authorName: "Test Author",
        number: nil,
        audioURL: nil,
        separatedAudioURL: nil,
        releaseDate: nil,
        chapters: nil,
        podcastPopularityScore: nil,
        podcastPriority: nil,
        audiobookId: nil,
        articleId: nil
    )
    
    static let sampleHomeSection = HomeSection(
        name: "Test Section",
        type: .square,
        contentType: .podcast,
        order: 1,
        content: [sampleContentItem]
    )
    
    static let samplePagination = Pagination(
        nextPage: "/home_sections?page=2",
        totalPages: 5,
        currentPage: 1
    )
    
    static let sampleHomeAPIResponse = HomeAPIResponse(
        sections: [sampleHomeSection],
        pagination: samplePagination
    )
    
    static let sampleSearchResponse = SearchResponse(
        results: [sampleContentItem],
        totalCount: 1,
        pagination: samplePagination
    )
}
