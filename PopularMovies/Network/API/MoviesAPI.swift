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
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .fetchPopularMovies, .searchMovies:
            return .get
        }
    }
    
    var task: Task {
        switch self {
        case .fetchPopularMovies(let page):
            return .requestParameters(parameters: ["language": "en-US", "page": page], encoding: URLEncoding.default)
        case .searchMovies(let query, let page):
            return .requestParameters(parameters: ["api_key": "YOUR_API_KEY", "query": query, "page": page], encoding: URLEncoding.default)
        }
    }
    
    var headers: [String: String]? {
        return [
            "Authorization": "Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiI3Mjc1Y2RkN2M1NzhiZTNkZjIwNjFiZDMyZDBhOWQzOCIsIm5iZiI6MTU2Mjg3MjY1Ni42NDUsInN1YiI6IjVkMjc4YjUwOWMyNGZjMDAxMGEzNTIzNSIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.l6RnC5CPWLYo94f1uxzJuqNuS6Ixiobp1yxXI_L3i5o",
            "Accept": "application/json"
        ]
    }
}
