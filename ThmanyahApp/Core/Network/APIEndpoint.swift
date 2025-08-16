//
//  APIEndpoint.swift
//  ThmanyahApp
//
//  Created by Ahmed Mahrous on 16/08/2025.
//

import Foundation

enum APIEndpoint {
    case homeSections(page: Int = 1)
    case search(query: String, page: Int = 1, limit: Int = APIConstants.Pagination.defaultPageSize)
    
    var url: URL {
        switch self {
        case .homeSections(let page):
            var components = URLComponents(string: APIConstants.baseURL + APIConstants.Endpoints.homeSections)!
            components.queryItems = [
                URLQueryItem(name: "page", value: "\(page)")
            ]
            return components.url!
            
        case .search(let query, let page, let limit):
            var components = URLComponents(string: APIConstants.searchBaseURL + APIConstants.Endpoints.search)!
            let encodedQuery = query.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
            components.queryItems = [
                URLQueryItem(name: "q", value: encodedQuery),
                URLQueryItem(name: "page", value: "\(page)"),
                URLQueryItem(name: "limit", value: "\(limit)")
            ]
            return components.url!
        }
    }
    
    var httpMethod: String {
        return "GET"
    }
    
    var headers: [String: String] {
        return [
            "Content-Type": "application/json",
            "Accept": "application/json"
        ]
    }
    
    var cachePolicy: URLRequest.CachePolicy {
        switch self {
        case .homeSections:
            return .reloadRevalidatingCacheData
        case .search:
            return .reloadIgnoringLocalCacheData
        }
    }
    
    var timeoutInterval: TimeInterval {
        return APIConstants.Network.timeoutInterval
    }
}
