//
//  TwoLinesItemView.swift
//  ThmanyahApp
//
//  Created by Ahmed Mahrous on 18/08/2025.
//

import SwiftUI

struct TwoLinesItemView: View {
    let item: ContentItem
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            AsyncImage(url: URL(string: item.model.avatarUrl)) { image in
                image
                    .resizable()
                    .aspectRatio(contentMode: .fill)
            } placeholder: {
                Rectangle()
                    .foregroundColor(.appCardBackground)
                    .overlay(
                        Image(systemName: item.model.contentIcon)
                            .font(.system(size: 32))
                            .foregroundColor(.gray)
                    )
                    .shimmerEffect()
            }
            .frame(width: 140, height: 140)
            .cornerRadius(AppConstants.Layout.cornerRadius)
            .clipped()
            
            VStack(alignment: .leading, spacing: 6) {
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
                
                if let metadata = getMetadata() {
                    Text(metadata)
                        .font(.custom(FontNames.IBMPlexSansArabicRegular, size: 10))
                        .foregroundColor(.orange.opacity(0.8))
                        .lineLimit(1)
                }
            }
        }
        .frame(width: 140)
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
            return podcast.description.truncated(to: 50)
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
    let sampleEpisode = Episode(
        id: "1",
        name: "حلقة تجريبية طويلة الاسم جداً",
        podcastName: "بودكاست تجريبي",
        description: "وصف الحلقة",
        avatarUrl: "https://picsum.photos/200",
        duration: 2400,
        releaseDate: Date(),
        audioUrl: "",
        score: 4.2
    )
    
    let contentItem = ContentItem(id: "test#1#1", model: sampleEpisode)
    
    return TwoLinesItemView(item: contentItem)
        .background(Color.black)
        .padding()
}
