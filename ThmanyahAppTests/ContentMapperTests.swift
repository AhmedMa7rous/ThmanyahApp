import XCTest
@testable import ThmanyahApp

final class ContentMapperTests: XCTestCase {
    func test_mapToSection_builds_ContentItems_withStableIDs() throws {
        let sectionDTO = SectionDTO(
            name: "Trending",
            type: "square",
            contentType: "podcast",
            order: 1,
            content: [
                ContentDTO(name: "Swift Talk", avatarUrl: "https://example.com", duration: 3600, score: 4.5,
                           podcastId: "p1", description: "D", episodeCount: 10, language: "ar",
                           priority: 1, popularityScore: 100,
                           episodeId: nil, podcastName: nil, audioUrl: nil, releaseDate: nil,
                           audiobookId: nil, authorName: nil, articleId: nil)
            ]
        )
        let section = ContentMapper.mapToSection(sectionDTO)
        XCTAssertEqual(section.content.count, 1)
        let id = section.content.first!.id
        XCTAssertTrue(id.contains("Trending#0#p1"))
    }

    func test_mapToPodcast_returns_nil_if_required_missing() {
        let dto = ContentDTO(name: nil, avatarUrl: nil, duration: nil, score: nil,
                             podcastId: nil, description: nil, episodeCount: nil, language: nil, priority: nil, popularityScore: nil,
                             episodeId: nil, podcastName: nil, audioUrl: nil, releaseDate: nil,
                             audiobookId: nil, authorName: nil, articleId: nil)
        let mirror = ContentMapper.self
        // Using internal API via test-only extension would be ideal, but here we validate through the section route
        let sectionDTO = SectionDTO(name: "S", type: "square", contentType: "podcast", order: 1, content: [dto])
        let section = ContentMapper.mapToSection(sectionDTO)
        XCTAssertEqual(section.content.count, 0, "Invalid podcast DTO should be dropped")
    }

    func test_mapSearchToSection_parses_string_numbers() {
        let searchContent = SearchContentDTO(
            name: "Clean Architecture",
            avatarUrl: "https://example.com",
            duration: "5400",
            score: "4.2",
            podcastId: nil, description: "Book", episodeCount: nil, language: "ar",
            priority: "1", popularityScore: "99",
            episodeId: nil, podcastName: nil, audioUrl: nil, releaseDate: "2025-07-01T00:00:00Z",
            audiobookId: "a1", authorName: "Uncle Bob", articleId: nil
        )
        let searchDTO = SearchSectionDTO(name: "Books", type: "big_square", contentType: "audio_book", order: "1", content: [searchContent])
        let section = ContentMapper.mapSearchToSection(searchDTO)
        XCTAssertEqual(section.content.count, 1)
        XCTAssertTrue(section.content.first!.id.contains("Books#0#a1"))
    }
}
