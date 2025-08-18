//
//  APIConstants.swift
//  ThmanyahApp
//
//  Created by Ahmed Mahrous on 15/08/2025.
//

import Foundation

struct APIConstants {
    static let baseURL = "https://api-v2-b2sit6oh3a-uc.a.run.app"
    static let searchBaseURL = "https://mock.apidog.com/m1/735111-711675-default"
    
    struct Endpoints {
        static let homeSections = "/home_sections"
        static let search = "/search"
    }
    
    struct Pagination {
        static let defaultPageSize = 20
        static let maxPageSize = 50
    }
    
    struct Network {
        static let timeoutInterval: TimeInterval = 30
        static let cachePolicy: URLRequest.CachePolicy = .reloadIgnoringLocalCacheData
    }
}
