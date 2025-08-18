import Foundation
@testable import ThmanyahApp

final class MockNetworkService: NetworkServiceProtocol {
    enum Mode {
        case success((APIEndpoint) -> Data)
        case failure(Error)
    }
    var mode: Mode = .failure(NetworkError.noData)

    func request<T: Codable>(_ endpoint: APIEndpoint) async throws -> T {
        switch mode {
        case .success(let provider):
            let data = provider(endpoint)
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .useDefaultKeys
            decoder.dateDecodingStrategy = .iso8601
            return try decoder.decode(T.self, from: data)
        case .failure(let error):
            if let e = error as? NetworkError { throw e }
            throw NetworkError.networkError(error.localizedDescription)
        }
    }
}
