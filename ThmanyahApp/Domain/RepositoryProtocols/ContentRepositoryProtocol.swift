//
//  ContentRepositoryProtocol.swift
//  ThmanyahApp
//
//  Created by Ahmed Mahrous on 18/08/2025.
//

import Foundation

protocol ContentRepositoryProtocol {
    func fetchHomeSections(page: Int) async throws -> (sections: [HomeSection], pagination: Pagination)
    func searchContent(query: String, page: Int, limit: Int) async throws -> (sections: [HomeSection], pagination: Pagination)
}
