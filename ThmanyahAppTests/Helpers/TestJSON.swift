import Foundation

enum TestJSON {
    static let homeSuccess = """
    {
      "sections": [
        {
          "name": "Trending",
          "type": "square",
          "content_type": "podcast",
          "order": 1,
          "content": [
            {
              "podcast_id": "p1",
              "name": "Swift Talk",
              "avatar_url": "https://example.com/podcast.jpg",
              "episode_count": 12,
              "duration": 3600,
              "language": "ar",
              "priority": 1,
              "popularity_score": 80,
              "description": "Desc",
              "score": 4.5
            }
          ]
        },
        {
          "name": "Latest Episodes",
          "type": "2_lines_grid",
          "content_type": "episode",
          "order": 2,
          "content": [
            {
              "episode_id": "e1",
              "name": "Episode 1",
              "avatar_url": "https://example.com/ep.jpg",
              "podcast_name": "Swift Talk",
              "audio_url": "https://example.com/a.mp3",
              "release_date": "2025-08-01T00:00:00Z",
              "duration": 1800,
              "description": "D",
              "score": 4.0
            }
          ]
        }
      ],
      "pagination": { "next_page": "2", "total_pages": 3 }
    }
    """.data(using: .utf8)!

    static let searchSuccess = """
    {
      "sections": [
        {
          "name": "Search",
          "type": "big_square",
          "content_type": "audio_book",
          "order": "1",
          "content": [
            {
              "audiobook_id": "a1",
              "name": "Clean Architecture",
              "avatar_url": "https://example.com/book.jpg",
              "author_name": "Uncle Bob",
              "release_date": "2025-07-01T00:00:00Z",
              "duration": "5400",
              "language": "ar",
              "score": "4.2"
            }
          ]
        }
      ]
    }
    """.data(using: .utf8)!

    static let invalid = """
    { "sectionsx": [] }
    """.data(using: .utf8)!
}
