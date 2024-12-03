//
//  NetworkError.swift
//  PopularMovies
//
//  Created by jobzella on 12/3/24.
//

import Foundation
import Moya
enum NetworkError: Error, LocalizedError {
    case networkFailure(Error)
    case decodingError
    case invalidStatusCode(Int)
    case unknownError
    
    var errorDescription: String? {
        switch self {
        case .networkFailure(let error):
            return "Network error: \(error.localizedDescription)"
        case .decodingError:
            return "Failed to decode the data."
        case .invalidStatusCode(let code):
            return "Received an invalid status code: \(code)."
        case .unknownError:
            return "An unknown error occurred."
        }
    }
}

extension MoyaError {
    func asNetworkError() -> NetworkError {
        switch self {
        case .statusCode(let response):
            return .invalidStatusCode(response.statusCode)
        default:
            return .networkFailure(self)
        }
    }
}
