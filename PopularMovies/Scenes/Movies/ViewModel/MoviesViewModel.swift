//
//  MoviesViewModel.swift
//  PopularMovies
//
//  Created by jobzella on 12/3/24.
//

import Foundation
class MovieViewModel {
    var moviesDidChange: (() -> Void)?
    var showError: ((String) -> Void)?
    var isLoading: ((Bool) -> Void)?

    private let movieService: MovieService
    private var movies: [Movie] = []

    init(movieService: MovieService = MovieService()) {
        self.movieService = movieService
    }
    func fetchPopularMovies(page: Int) {
        isLoading?(true)
        
        movieService.fetchPopularMovies(page: page) { [weak self] response, error in
            self?.isLoading?(false)
            
            if let error = error {
                self?.showError?(error.localizedDescription)
                return
            }
            
            if let response = response {
                self?.movies = response.results
                self?.moviesDidChange?()  // Notify the ViewController to update the UI
            }
        }
    }
    
    func getMovieCount() -> Int {
        return movies.count
    }
    
    func getMovie(at index: Int) -> Movie? {
        guard index >= 0 && index < movies.count else { return nil }
        return movies[index]
    }

}
