//
//  BigSquareItemView.swift
//  ThmanyahApp
//
//  Created by Ahmed Mahrous on 18/08/2025.
//

import SwiftUI

struct BigSquareItemView: View {
    let item: ContentItem
    
    var body: some View {
        VStack(spacing: 12) {
            ZStack(alignment: .bottomLeading) {
                AsyncImage(url: URL(string: item.model.avatarUrl)) { image in
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                } placeholder: {
                    Rectangle()
                        .foregroundColor(.appCardBackground)
                        .overlay(
                            Image(systemName: item.model.contentIcon)
                                .font(.system(size: 40))
                                .foregroundColor(.gray)
                        )
                        .shimmerEffect()
                }
                .frame(height: 160)
                .cornerRadius(AppConstants.Layout.cornerRadius)
                .clipped()
                
                // Overlay gradient for better text readability
                LinearGradient(
                    colors: [.clear, .black.opacity(0.7)],
                    startPoint: .top,
                    endPoint: .bottom
                )
                .cornerRadius(AppConstants.Layout.cornerRadius)
                
                // Content type badge
                HStack {
                    Image(systemName: item.model.contentIcon)
                        .font(.system(size: 12))
                    Text(item.model.contentType.displayName)
                        .font(.custom(FontNames.IBMPlexSansArabicRegular, size: 10))
                }
                .foregroundColor(.white)
                .padding(.horizontal, 8)
                .padding(.vertical, 4)
                .background(Color.black.opacity(0.7))
                .cornerRadius(12)
                .padding([.leading, .bottom], 8)
            }
            
            VStack(alignment: .leading, spacing: 6) {
                Text(item.model.name)
                    .font(.custom(FontNames.IBMPlexSansArabicMedium, size: 14))
                    .foregroundColor(.white)
                    .lineLimit(2)
                    .multilineTextAlignment(.leading)
                
                if let subtitle = getSubtitle() {
                    Text(subtitle)
                        .font(.custom(FontNames.IBMPlexSansArabicRegular, size: 12))
                        .foregroundColor(.gray)
                        .lineLimit(1)
                }
                
                HStack {
                    if let metadata = getMetadata() {
                        Text(metadata)
                            .font(.custom(FontNames.IBMPlexSansArabicRegular, size: 10))
                            .foregroundColor(.orange.opacity(0.8))
                    }
                    
                    Spacer()
                    
                    if item.model.score > 0 {
                        HStack(spacing: 2) {
                            Image(systemName: "star.fill")
                                .font(.system(size: 8))
                                .foregroundColor(.yellow)
                            Text(String(format: "%.1f", item.model.score))
                                .font(.custom(FontNames.IBMPlexSansArabicRegular, size: 10))
                                .foregroundColor(.gray)
                        }
                    }
                }
            }
        }
    }
    
    private func getSubtitle() -> String? {
        switch item.model {
        case let episode as Episode:
            return episode.podcastName
        case let audioBook as AudioBook:
            return audioBook.authorText
        case let audioArticle as AudioArticle:
            return audioArticle.authorText
        case let podcast as Podcast:
            return podcast.description.truncated(to: 60)
        default:
            return nil
        }
    }
    
    private func getMetadata() -> String? {
        switch item.model {
        case let podcast as Podcast:
            return podcast.episodeCountText
        case is Episode, is AudioBook, is AudioArticle:
            return item.model.formattedDuration
        default:
            return nil
        }
    }
}

#Preview {
    let sampleAudioBook = AudioBook(
        id: "1",
        name: "كتاب صوتي تجريبي طويل الاسم",
        authorName: "الكاتب التجريبي",
        description: "وصف الكتاب",
        avatarUrl: "https://picsum.photos/200",
        duration: 7200,
        language: "ar",
        releaseDate: Date(),
        score: 4.8
    )
    
    let contentItem = ContentItem(id: "test#1#1", model: sampleAudioBook)
    
    return BigSquareItemView(item: contentItem)
        .background(Color.black)
        .padding()
}
