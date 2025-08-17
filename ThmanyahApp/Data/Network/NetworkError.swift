//
//  NetworkError.swift
//  ThmanyahApp
//
//  Created by Ahmed Mahrous on 16/08/2025.
//

import Foundation

enum NetworkError: Error, LocalizedError, Equatable {
    case invalidURL
    case noData
    case decodingError(String)
    case networkError(String)
    case timeout
    case serverError(Int)
    case unauthorized
    case forbidden
    case notFound
    case tooManyRequests
    
    var errorDescription: String? {
        switch self {
        case .invalidURL:
            return "Invalid URL provided"
        case .noData:
            return "No data received from server"
        case .decodingError(let details):
            return "Failed to decode response: \(details)"
        case .networkError(let details):
            return "Network error: \(details)"
        case .timeout:
            return "Request timed out"
        case .serverError(let code):
            return "Server error with code: \(code)"
        case .unauthorized:
            return "Unauthorized access"
        case .forbidden:
            return "Access forbidden"
        case .notFound:
            return "Resource not found"
        case .tooManyRequests:
            return "Too many requests. Please try again later"
        }
    }
    
    var recoverySuggestion: String? {
        switch self {
        case .timeout, .networkError:
            return "Please check your internet connection and try again"
        case .serverError:
            return "Please try again later"
        case .unauthorized:
            return "Please check your credentials"
        case .tooManyRequests:
            return "Please wait a moment before trying again"
        default:
            return "Please try again"
        }
    }
    
    static func == (lhs: NetworkError, rhs: NetworkError) -> Bool {
        switch (lhs, rhs) {
        case (.invalidURL, .invalidURL),
             (.noData, .noData),
             (.timeout, .timeout),
             (.unauthorized, .unauthorized),
             (.forbidden, .forbidden),
             (.notFound, .notFound),
             (.tooManyRequests, .tooManyRequests):
            return true
        case (.decodingError(let lhsDetails), .decodingError(let rhsDetails)):
            return lhsDetails == rhsDetails
        case (.networkError(let lhsDetails), .networkError(let rhsDetails)):
            return lhsDetails == rhsDetails
        case (.serverError(let lhsCode), .serverError(let rhsCode)):
            return lhsCode == rhsCode
        default:
            return false
        }
    }
}
