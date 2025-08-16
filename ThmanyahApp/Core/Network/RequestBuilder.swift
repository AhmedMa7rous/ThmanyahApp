//
//  RequestBuilder.swift
//  ThmanyahApp
//
//  Created by Ahmed Mahrous on 16/08/2025.
//

import Foundation

struct RequestBuilder {
    static func build(for endpoint: APIEndpoint) -> URLRequest {
        var request = URLRequest(url: endpoint.url)
        request.httpMethod = endpoint.httpMethod
        request.cachePolicy = endpoint.cachePolicy
        request.timeoutInterval = endpoint.timeoutInterval
        
        for (key, value) in endpoint.headers {
            request.setValue(value, forHTTPHeaderField: key)
        }
        
        return request
    }
}
