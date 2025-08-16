//
//  Extensions.swift
//  ThmanyahApp
//
//  Created by Ahmed Mahrous on 16/08/2025.
//

import Foundation
import SwiftUI

// MARK: - String Extensions
extension String {
    var isNotEmpty: Bool {
        return !isEmpty
    }
    
    func trimmed() -> String {
        return trimmingCharacters(in: .whitespacesAndNewlines)
    }
}

// MARK: - Array Extensions
extension Array where Element: Identifiable {
    func removingDuplicates() -> [Element] {
        var seen = Set<Element.ID>()
        return filter { seen.insert($0.id).inserted }
    }
}
