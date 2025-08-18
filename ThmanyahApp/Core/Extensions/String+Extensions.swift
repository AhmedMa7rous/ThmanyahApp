//
//  String+Extensions.swift
//  ThmanyahApp
//
//  Created by Ahmed Mahrous on 18/08/2025.
//

import Foundation

extension String {
    var isValidSearchQuery: Bool {
        let trimmed = self.trimmingCharacters(in: .whitespacesAndNewlines)
        return !trimmed.isEmpty && trimmed.count >= 2
    }
    
    var urlEncoded: String {
        return addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
    }
    
    func truncated(to length: Int, trailing: String = "...") -> String {
        guard self.count > length else { return self }
        return String(self.prefix(length)) + trailing
    }
}
