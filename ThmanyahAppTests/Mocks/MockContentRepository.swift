import Foundation
@testable import ThmanyahApp

final class MockContentRepository: ContentRepositoryProtocol {
    var homeResult: Result<([HomeSection], Pagination), Error> = .failure(NetworkError.noData)
    var searchResult: Result<([HomeSection], Pagination), Error> = .failure(NetworkError.noData)

    func fetchHomeSections(page: Int) async throws -> (sections: [HomeSection], pagination: Pagination) {
        switch homeResult {
        case .success(let tuple): return tuple
        case .failure(let error): throw error
        }
    }

    func searchContent(query: String, page: Int, limit: Int) async throws -> (sections: [HomeSection], pagination: Pagination) {
        switch searchResult {
        case .success(let tuple): return tuple
        case .failure(let error): throw error
        }
    }
}
