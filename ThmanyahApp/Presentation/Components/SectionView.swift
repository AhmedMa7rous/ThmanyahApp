//
//  SectionView.swift
//  ThmanyahApp
//
//  Created by Ahmed Mahrous on 18/08/2025.
//

import SwiftUI

struct SectionView: View {
    let section: HomeSection
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            sectionHeader
            contentGrid
        }
    }
    
    private var sectionHeader: some View {
        HStack {
            VStack(alignment: .leading, spacing: 4) {
                Text(section.name)
                    .font(.custom(FontNames.IBMPlexSansArabicBold, size: 18))
                    .foregroundColor(.white)
                
                Text(section.contentType.displayName)
                    .font(.custom(FontNames.IBMPlexSansArabicRegular, size: 12))
                    .foregroundColor(.gray)
            }
            
            Spacer()
            
            Button(action: {}) {
                HStack(spacing: 4) {
                    Text("عرض الكل")
                        .font(.custom(FontNames.IBMPlexSansArabicMedium, size: 14))
                        .foregroundColor(.orange)
                    
                    Image(systemName: "chevron.left")
                        .font(.system(size: 12, weight: .medium))
                        .foregroundColor(.orange)
                }
            }
        }
    }
    
    @ViewBuilder
    private var contentGrid: some View {
        switch section.type {
        case .queue:
            queueLayout
        case .square:
            squareGridLayout
        case .twoLinesGrid:
            twoLinesScrollLayout
        case .bigSquare:
            bigSquareGridLayout
        }
    }
    
    private var queueLayout: some View {
        VStack(spacing: 12) {
            ForEach(Array(section.content.prefix(5).enumerated()), id: \.element.id) { index, item in
                QueueItemView(item: item, index: index + 1)
            }
        }
    }
    
    private var squareGridLayout: some View {
        LazyVGrid(
            columns: Array(repeating: GridItem(.flexible(), spacing: 12), count: 3),
            spacing: 12
        ) {
            ForEach(Array(section.content.prefix(6)), id: \.id) { item in
                SquareItemView(item: item)
            }
        }
    }
    
    private var twoLinesScrollLayout: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 12) {
                ForEach(section.content, id: \.id) { item in
                    TwoLinesItemView(item: item)
                }
            }
            .padding(.horizontal, 1)
        }
    }
    
    private var bigSquareGridLayout: some View {
        LazyVGrid(
            columns: Array(repeating: GridItem(.flexible(), spacing: 12), count: 2),
            spacing: 12
        ) {
            ForEach(Array(section.content.prefix(4)), id: \.id) { item in
                BigSquareItemView(item: item)
            }
        }
    }
}

#Preview {
    let samplePodcast = Podcast(
        id: "1",
        name: "بودكاست تجريبي",
        description: "وصف البودكاست",
        avatarUrl: "https://example.com/image.jpg",
        episodeCount: 25,
        duration: 3600,
        language: "ar",
        priority: 1,
        popularityScore: 100,
        score: 4.5
    )
    
    let contentItem = ContentItem(id: "test#1#1", model: samplePodcast)
    
    let sampleSection = HomeSection(
        name: "أحدث البودكاستات",
        type: .square,
        contentType: .podcast,
        order: 1,
        content: [contentItem]
    )
    
    SectionView(section: sampleSection)
        .background(Color.black)
        .padding()
}
