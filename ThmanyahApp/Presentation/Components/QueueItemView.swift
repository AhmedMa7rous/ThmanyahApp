//
//  QueueItemView.swift
//  ThmanyahApp
//
//  Created by Ahmed Mahrous on 18/08/2025.
//

import SwiftUI

struct QueueItemView: View {
    let item: ContentItem
    let index: Int
    
    var body: some View {
        HStack(spacing: 12) {
            // Index number
            Text("\(index)")
                .font(.custom(FontNames.IBMPlexSansArabicBold, size: 16))
                .foregroundColor(.orange)
                .frame(width: 24)
            
            // Thumbnail
            AsyncImage(url: URL(string: item.model.avatarUrl)) { image in
                image
                    .resizable()
                    .aspectRatio(contentMode: .fill)
            } placeholder: {
                Rectangle()
                    .foregroundColor(.appCardBackground)
                    .overlay(
                        Image(systemName: item.model.contentIcon)
                            .font(.system(size: 20))
                            .foregroundColor(.gray)
                    )
                    .shimmerEffect()
            }
            .frame(width: 56, height: 56)
            .cornerRadius(AppConstants.Layout.smallCornerRadius)
            .clipped()
            
            // Content info
            VStack(alignment: .leading, spacing: 4) {
                Text(item.model.name)
                    .font(.custom(FontNames.IBMPlexSansArabicMedium, size: 14))
                    .foregroundColor(.white)
                    .lineLimit(2)
                
                if let subtitle = getSubtitle() {
                    Text(subtitle)
                        .font(.custom(FontNames.IBMPlexSansArabicRegular, size: 12))
                        .foregroundColor(.gray)
                        .lineLimit(1)
                }
                
                HStack(spacing: 8) {
                    if let metadata = getMetadata() {
                        Text(metadata)
                            .font(.custom(FontNames.IBMPlexSansArabicRegular, size: 10))
                            .foregroundColor(.orange.opacity(0.8))
                    }
                    
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
            
            Spacer()
            
            // Action button
            Button(action: {}) {
                Image(systemName: "ellipsis")
                    .font(.system(size: 16, weight: .medium))
                    .foregroundColor(.gray)
                    .rotationEffect(.degrees(90))
            }
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 12)
        .background(Color.appCardBackground)
        .cornerRadius(AppConstants.Layout.cornerRadius)
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
            return podcast.description.truncated(to: 40)
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
    let samplePodcast = Podcast(
        id: "1",
        name: "بودكاست تجريبي طويل الاسم جداً ومفصل",
        description: "وصف مفصل للبودكاست التجريبي",
        avatarUrl: "https://picsum.photos/200",
        episodeCount: 42,
        duration: 3600,
        language: "ar",
        priority: 1,
        popularityScore: 100,
        score: 4.6
    )
    
    let contentItem = ContentItem(id: "test#1#1", model: samplePodcast)
    
    QueueItemView(item: contentItem, index: 1)
        .background(Color.black)
        .padding()
}
