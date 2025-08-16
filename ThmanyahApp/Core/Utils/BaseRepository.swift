//
//  BaseRepository.swift
//  ThmanyahApp
//
//  Created by Ahmed Mahrous on 16/08/2025.
//

import Foundation

protocol BaseRepositoryProtocol {
    associatedtype DataType
    func handleNetworkError(_ error: Error) -> Error
}

extension BaseRepositoryProtocol {
    func handleNetworkError(_ error: Error) -> Error {
        if let networkError = error as? NetworkError {
            return networkError
        }
        return NetworkError.networkError(error.localizedDescription)
    }
}
