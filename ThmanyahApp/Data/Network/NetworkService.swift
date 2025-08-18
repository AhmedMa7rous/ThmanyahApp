//
//  NetworkService.swift
//  ThmanyahApp
//
//  Created by Ahmed Mahrous on 16/08/2025.
//

import Foundation

protocol NetworkServiceProtocol {
    func request<T: Codable>(_ endpoint: APIEndpoint) async throws -> T
}

actor NetworkService: NetworkServiceProtocol {
    private let session: URLSession
    
    init(session: URLSession = .shared) {
        self.session = session
    }
    
    func request<T: Codable>(_ endpoint: APIEndpoint) async throws -> T {
        let request = buildRequest(for: endpoint)
        
        do {
            let (data, response) = try await session.data(for: request)
            
            guard let httpResponse = response as? HTTPURLResponse else {
                throw NetworkError.networkError("Invalid response type")
            }
            
            try validateResponse(httpResponse)
            
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .useDefaultKeys
            decoder.dateDecodingStrategy = .iso8601
            
            do {
                let result = try decoder.decode(T.self, from: data)
                return result
            } catch let decodingError as DecodingError {
                let errorDetails = formatDecodingError(decodingError)
                print("❌ Decoding Error: \(errorDetails)")
                print("📄 Raw Data: \(String(data: data, encoding: .utf8) ?? "Unable to convert data to string")")
                throw NetworkError.decodingError(errorDetails)
            }
            
        } catch is CancellationError {
            throw CancellationError()
        } catch let urlError as URLError {
            switch urlError.code {
            case .cancelled:
                throw CancellationError()
            case .timedOut:
                throw NetworkError.timeout
            default:
                throw NetworkError.networkError(urlError.localizedDescription)
            }
        } catch let error as NetworkError {
            throw error
        } catch {
            print("❌ Network Error: \(error)")
            throw NetworkError.networkError(error.localizedDescription)
        }
    }
    
    private func buildRequest(for endpoint: APIEndpoint) -> URLRequest {
        var request = URLRequest(url: endpoint.url)
        request.httpMethod = endpoint.httpMethod
        request.cachePolicy = endpoint.cachePolicy
        request.timeoutInterval = endpoint.timeoutInterval
        
        for (key, value) in endpoint.headers {
            request.setValue(value, forHTTPHeaderField: key)
        }
        
        print("🌐 Making request to: \(endpoint.url)")
        return request
    }
    
    private func validateResponse(_ response: HTTPURLResponse) throws {
        switch response.statusCode {
        case 200...299:
            return
        case 400:
            throw NetworkError.networkError("Bad Request")
        case 401:
            throw NetworkError.unauthorized
        case 403:
            throw NetworkError.forbidden
        case 404:
            throw NetworkError.notFound
        case 429:
            throw NetworkError.tooManyRequests
        case 500...599:
            throw NetworkError.serverError(response.statusCode)
        default:
            throw NetworkError.networkError("HTTP \(response.statusCode)")
        }
    }
    
    private func formatDecodingError(_ error: DecodingError) -> String {
        switch error {
        case .typeMismatch(let type, let context):
            return "Type mismatch for \(type) at \(context.codingPath)"
        case .valueNotFound(let type, let context):
            return "Value not found for \(type) at \(context.codingPath)"
        case .keyNotFound(let key, let context):
            return "Key '\(key)' not found at \(context.codingPath)"
        case .dataCorrupted(let context):
            return "Data corrupted at \(context.codingPath): \(context.debugDescription)"
        @unknown default:
            return "Unknown decoding error: \(error.localizedDescription)"
        }
    }
}
