//
//  MoviesAPI.swift
//  PopularMovies
//
//  Created by jobzella on 12/3/24.
//

import Foundation
import Moya

enum MovieAPI {
    case fetchPopularMovies(page: Int)
    case searchMovies(query: String, page: Int)
    case fetchMovieDetails(id: Int)
    case fetchSimilarMovies(page: Int,id: Int)
    case fetchCredits(page: Int,id: Int)


}

extension MovieAPI: TargetType {
    var baseURL: URL {
        return URL(string: "https://api.themoviedb.org/3")!
    }
    
    var path: String {
        switch self {
        case .fetchPopularMovies:
            return "/movie/popular"
        case .searchMovies:
            return "/search/movie"
        case .fetchMovieDetails(let id):
            return "/movie/\(id)"
        case .fetchSimilarMovies(_,let id):
            return "/movie/\(id)/similar"
        case .fetchCredits(_,let id):
            return "/movie/\(id)/credits"


        }
    }
    
    var method: Moya.Method {
        switch self {
        case .fetchPopularMovies, .searchMovies,.fetchMovieDetails,.fetchSimilarMovies,.fetchCredits:
            return .get
        }
    }
    
    var task: Task {
        switch self {
        case .fetchPopularMovies(let page),.fetchSimilarMovies(let page, _),.fetchCredits(let page, _):
            return .requestParameters(parameters: ["language": "en-US", "page": page], encoding: URLEncoding.default)
        case .searchMovies(let query, let page):
            return .requestParameters(parameters: ["query": query, "page": page], encoding: URLEncoding.default)
        case .fetchMovieDetails:
            return .requestParameters(parameters: ["language": "en-US"], encoding: URLEncoding.default)

        }
    }
    
    var headers: [String: String]? {
        return [
            "Authorization": "Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiI3Mjc1Y2RkN2M1NzhiZTNkZjIwNjFiZDMyZDBhOWQzOCIsIm5iZiI6MTU2Mjg3MjY1Ni42NDUsInN1YiI6IjVkMjc4YjUwOWMyNGZjMDAxMGEzNTIzNSIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.l6RnC5CPWLYo94f1uxzJuqNuS6Ixiobp1yxXI_L3i5o",
            "Accept": "application/json"
        ]
    }
}
