//
//  NetworkManager.swift
//  PopularMovies
//
//  Created by jobzella on 12/3/24.
//

import Foundation

import Moya
protocol NetworkManager {
    associatedtype Target: TargetType

    func fetchData<T: Decodable>(endpoint: Target, responseType: T.Type, completion: @escaping (T?, NetworkError?) -> Void)
}

extension NetworkManager {
    
    func fetchData<T: Decodable>(endpoint: Target, responseType: T.Type, completion: @escaping (T?, NetworkError?) -> Void) {
        let provider = MoyaProvider<Target>()

        provider.request(endpoint) { result in
            switch result {
            case .success(let response):
                
                guard (200..<300).contains(response.statusCode) else {
                    completion(nil, NetworkError.invalidStatusCode(response.statusCode))
                    return
                }
                
                do {
                    let decodedModel = try JSONDecoder().decode(T.self, from: response.data)
                    completion(decodedModel, nil)  // Return the decoded model with no error
                } catch {
                    completion(nil, .decodingError) // Return decoding error
                }
                
            case .failure(let error):
                let networkError = error.asNetworkError()
                completion(nil, networkError) // Return error
            }
        }
    }
}
