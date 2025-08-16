//
//  Chapter.swift
//  ThmanyahApp
//
//  Created by Ahmed Mahrous on 15/08/2025.
//

import Foundation

struct Chapter: Codable, Identifiable {
    let title: String?
    let startTime: Int?
    let endTime: Int?
    
    enum CodingKeys: String, CodingKey {
        case title
        case startTime = "start_time"
        case endTime = "end_time"
    }
    
    var id: String {
        return "\(title ?? "chapter")_\(startTime ?? 0)"
    }
    
    var formattedStartTime: String? {
        guard let startTime = startTime else { return nil }
        let minutes = startTime / 60
        let seconds = startTime % 60
        return String(format: "%d:%02d", minutes, seconds)
    }
}
