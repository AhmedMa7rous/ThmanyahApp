//
//  SquareItemView.swift
//  ThmanyahApp
//
//  Created by Ahmed Mahrous on 18/08/2025.
//

import SwiftUI

struct SquareItemView: View {
    let item: ContentItem
    
    var body: some View {
        VStack(spacing: 8) {
            AsyncImage(url: URL(string: item.model.avatarUrl)) { image in
                image
                    .resizable()
                    .aspectRatio(contentMode: .fill)
            } placeholder: {
                Rectangle()
                    .foregroundColor(.appCardBackground)
                    .overlay(
                        Image(systemName: item.model.contentIcon)
                            .font(.system(size: 24))
                            .foregroundColor(.gray)
                    )
                    .shimmerEffect()
            }
            .frame(width: 100, height: 100)
            .cornerRadius(AppConstants.Layout.smallCornerRadius)
            .clipped()
            
            VStack(spacing: 4) {
                Text(item.model.name)
                    .font(.custom(FontNames.IBMPlexSansArabicMedium, size: 12))
                    .foregroundColor(.white)
                    .lineLimit(2)
                    .multilineTextAlignment(.center)
                
                if let subtitle = getSubtitle() {
                    Text(subtitle)
                        .font(.custom(FontNames.IBMPlexSansArabicRegular, size: 10))
                        .foregroundColor(.gray)
                        .lineLimit(1)
                }
            }
        }
        .frame(width: 100)
    }
    
    private func getSubtitle() -> String? {
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
        name: "بودكاست تجريبي طويل الاسم",
        description: "وصف",
        avatarUrl: "https://picsum.photos/200",
        episodeCount: 25,
        duration: 3600,
        language: "ar",
        priority: 1,
        popularityScore: 100,
        score: 4.5
    )
    
    let contentItem = ContentItem(id: "test#1#1", model: samplePodcast)
    
    SquareItemView(item: contentItem)
        .background(Color.black)
        .padding()
}
