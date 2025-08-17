//
//  ContentProtocol.swift
//  ThmanyahApp
//
//  Created by Ahmed Mahrous on 17/08/2025.
//

import Foundation

protocol ContentProtocol: Identifiable, Equatable, Hashable {
    var id: String { get }
    var name: String { get }
    var avatarUrl: String { get }
    var contentType: ContentType { get }
}

extension ContentProtocol {
    static func == (lhs: Self, rhs: Self) -> Bool {
        return lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}
