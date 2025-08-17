//
//  ContentMapper.swift
//  ThmanyahApp
//
//  Created by Ahmed Mahrous on 18/08/2025.
//

import Foundation

final class ContentMapper {
    static func mapToSection(_ dto: SectionDTO) -> HomeSection {
        let sectionType = SectionType(rawValue: dto.type) ?? .square
        let contentType = ContentType(rawValue: dto.contentType) ?? .podcast
        
        let items: [any ContentProtocol] = dto.content.compactMap { contentDTO in
            switch contentType {
            case .podcast:
                return mapToPodcast(contentDTO)
            case .episode:
                return mapToEpisode(contentDTO)
            case .audioBook:
                return mapToAudioBook(contentDTO)
            case .audioArticle:
                return mapToAudioArticle(contentDTO)
            }
        }
        
        let contentItems = items.enumerated().map { idx, item in
            ContentItem(id: "\(dto.name)#\(idx)#\(item.id)", model: item)
        }
        
        return HomeSection(
            name: dto.name,
            type: sectionType,
            contentType: contentType,
            order: dto.order,
            content: contentItems
        )
    }
    
    static func mapSearchToSection(_ searchDTO: SearchSectionDTO) -> HomeSection {
        // Convert search DTO to regular DTO first
        let regularDTO = SectionDTO(
            name: searchDTO.name,
            type: searchDTO.type,
            contentType: searchDTO.contentType,
            order: Int(searchDTO.order) ?? 0,
            content: searchDTO.content.map { mapSearchToContentDTO($0) }
        )
        
        return mapToSection(regularDTO)
    }
    
    private static func mapSearchToContentDTO(_ searchContent: SearchContentDTO) -> ContentDTO {
        return ContentDTO(
            name: searchContent.name,
            avatarUrl: searchContent.avatarUrl,
            duration: searchContent.duration.flatMap { Int($0) },
            score: searchContent.score.flatMap { Double($0) },
            podcastId: searchContent.podcastId,
            description: searchContent.description,
            episodeCount: searchContent.episodeCount.flatMap { Int($0) },
            language: searchContent.language,
            priority: searchContent.priority,
            popularityScore: searchContent.popularityScore,
            episodeId: searchContent.episodeId,
            podcastName: searchContent.podcastName,
            audioUrl: searchContent.audioUrl,
            releaseDate: searchContent.releaseDate,
            audiobookId: searchContent.audiobookId,
            authorName: searchContent.authorName,
            articleId: searchContent.articleId
        )
    }
    
    private static func mapToPodcast(_ dto: ContentDTO) -> Podcast? {
        guard let id = dto.podcastId,
              let name = dto.name,
              let avatarUrl = dto.avatarUrl else {
            print("⚠️ Missing required fields for Podcast: id=\(dto.podcastId ?? "nil"), name=\(dto.name ?? "nil"), avatarUrl=\(dto.avatarUrl ?? "nil")")
            return nil
        }
        
        return Podcast(
            id: id,
            name: name,
            description: dto.description ?? "",
            avatarUrl: avatarUrl,
            episodeCount: dto.episodeCount ?? 0,
            duration: dto.duration ?? 0,
            language: dto.language ?? "",
            priority: dto.priority ?? "",
            popularityScore: dto.popularityScore ?? "",
            score: dto.score ?? 0
        )
    }
    
    private static func mapToEpisode(_ dto: ContentDTO) -> Episode? {
        guard let id = dto.episodeId,
              let name = dto.name,
              let avatarUrl = dto.avatarUrl else {
            print("⚠️ Missing required fields for Episode: id=\(dto.episodeId ?? "nil"), name=\(dto.name ?? "nil"), avatarUrl=\(dto.avatarUrl ?? "nil")")
            return nil
        }
        
        let dateFormatter = ISO8601DateFormatter()
        let releaseDate = dto.releaseDate.flatMap { dateFormatter.date(from: $0) } ?? Date()
        
        return Episode(
            id: id,
            name: name,
            podcastName: dto.podcastName ?? "",
            description: dto.description ?? "",
            avatarUrl: avatarUrl,
            duration: dto.duration ?? 0,
            releaseDate: releaseDate,
            audioUrl: dto.audioUrl ?? "",
            score: dto.score ?? 0
        )
    }
    
    private static func mapToAudioBook(_ dto: ContentDTO) -> AudioBook? {
        guard let id = dto.audiobookId,
              let name = dto.name,
              let avatarUrl = dto.avatarUrl else {
            print("⚠️ Missing required fields for AudioBook: id=\(dto.audiobookId ?? "nil"), name=\(dto.name ?? "nil"), avatarUrl=\(dto.avatarUrl ?? "nil")")
            return nil
        }
        
        let dateFormatter = ISO8601DateFormatter()
        let releaseDate = dto.releaseDate.flatMap { dateFormatter.date(from: $0) } ?? Date()
        
        return AudioBook(
            id: id,
            name: name,
            authorName: dto.authorName ?? "",
            description: dto.description ?? "",
            avatarUrl: avatarUrl,
            duration: dto.duration ?? 0,
            language: dto.language ?? "",
            releaseDate: releaseDate,
            score: dto.score ?? 0
        )
    }
    
    private static func mapToAudioArticle(_ dto: ContentDTO) -> AudioArticle? {
        guard let id = dto.articleId,
              let name = dto.name,
              let avatarUrl = dto.avatarUrl else {
            print("⚠️ Missing required fields for AudioArticle: id=\(dto.articleId ?? "nil"), name=\(dto.name ?? "nil"), avatarUrl=\(dto.avatarUrl ?? "nil")")
            return nil
        }
        
        let dateFormatter = ISO8601DateFormatter()
        let releaseDate = dto.releaseDate.flatMap { dateFormatter.date(from: $0) } ?? Date()
        
        return AudioArticle(
            id: id,
            name: name,
            authorName: dto.authorName ?? "",
            description: dto.description ?? "",
            avatarUrl: avatarUrl,
            duration: dto.duration ?? 0,
            releaseDate: releaseDate,
            score: dto.score ?? 0
        )
    }
    
    static func mapToPagination(_ dto: PaginationDTO, currentPage: Int) -> Pagination {
        return Pagination(
            nextPage: dto.nextPage,
            totalPages: dto.totalPages,
            currentPage: currentPage
        )
    }
}
