//
//  MovieService.swift
//  PopularMovies
//
//  Created by jobzella on 12/3/24.
//

import Foundation
import Moya

protocol MovieServiceProtocol {
    func fetchPopularMovies(page: Int, completion: @escaping (MovieResponse?, NetworkError?) -> Void)
    func searchMovies(query: String, page: Int, completion: @escaping (MovieResponse?, NetworkError?) -> Void)
}

class MovieService:MovieServiceProtocol,NetworkManager{
    typealias Target = MovieAPI
    
    func fetchPopularMovies(page: Int, completion: @escaping (MovieResponse?, NetworkError?) -> Void) {
        let endpoint = MovieAPI.fetchPopularMovies(page: page)
        fetchData(endpoint: endpoint, responseType: MovieResponse.self, completion: completion)

    }
    
    func searchMovies(query: String, page: Int, completion: @escaping (MovieResponse?, NetworkError?) -> Void) {
        let endpoint = MovieAPI.searchMovies(query: query, page: page)
        fetchData(endpoint: endpoint, responseType: MovieResponse.self, completion: completion)

    }
    

    
}
