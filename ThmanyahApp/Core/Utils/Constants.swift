//
//  Constants.swift
//  ThmanyahApp
//
//  Created by Ahmed Mahrous on 18/08/2025.
//

import Foundation

struct FontNames {
    static let IBMPlexSansArabicRegular = "IBMPlexSansArabic-Regular"
    static let IBMPlexSansArabicMedium = "IBMPlexSansArabic-Medium"
    static let IBMPlexSansArabicBold = "IBMPlexSansArabic-Bold"
}

struct AppConstants {
    struct Animation {
        static let defaultDuration: Double = 0.3
        static let fastDuration: Double = 0.15
        static let slowDuration: Double = 0.6
    }
    
    struct Layout {
        static let cornerRadius: CGFloat = 12
        static let smallCornerRadius: CGFloat = 8
        static let defaultPadding: CGFloat = 16
        static let smallPadding: CGFloat = 8
        static let largePadding: CGFloat = 24
    }
    
    struct Images {
        static let placeholderSize: CGFloat = 50
        static let thumbnailSize: CGFloat = 100
        static let largeImageSize: CGFloat = 200
    }
}
