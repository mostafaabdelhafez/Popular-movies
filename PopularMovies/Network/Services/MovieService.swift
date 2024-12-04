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
    func fetchSimilarMovies(page: Int,id:Int, completion: @escaping (MovieResponse?, NetworkError?) -> Void)

    func movieDetails(id:Int, completion: @escaping (MovieDetails?, NetworkError?) -> Void)

}

class MovieService:MovieServiceProtocol,NetworkManager{
    func fetchSimilarMovies(page: Int,id:Int, completion: @escaping (MovieResponse?, NetworkError?) -> Void) {
        let endpoint = MovieAPI.fetchSimilarMovies(page: 1, id: id)
        fetchData(endpoint: endpoint, responseType: MovieResponse.self, completion: completion)
    }
    
    func movieDetails(id: Int, completion: @escaping (MovieDetails?, NetworkError?) -> Void) {
        let endpoint = MovieAPI.fetchMovieDetails(id: id)
        fetchData(endpoint: endpoint, responseType: MovieDetails.self, completion: completion)
    }
    
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
