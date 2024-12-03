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
    private var popularMovies: [Movie] = []
    private var searchResults: [Movie] = []

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
                
                self?.popularMovies = response.results ?? []
                self?.moviesDidChange?()  // Notify the ViewController to update the UI
            }
        }
    }
    func didRemoveSearch(){
        self.resetToPopularMovies()
    }
    func searchMovies(query: String, page: Int) {
        guard !query.isEmpty else {
            // If search is empty, reset to popular movies
            self.resetToPopularMovies()
            return
        }
        
        isLoading?(true)
        
        movieService.searchMovies(query: query, page: page) { [weak self] response, error in
            self?.isLoading?(false)
            
            if let error = error {
                self?.showError?(error.localizedDescription)
                return
            }
            
            if let response = response {
                self?.searchResults = response.results ?? []
                self?.moviesDidChange?()  // Notify ViewController to update UI
            }
        }
    }
    

    private func resetToPopularMovies() {
        self.searchResults.removeAll()
        self.fetchPopularMovies(page: 1)
    }

    func getMovieCount() -> Int {
        if !searchResults.isEmpty {
            return searchResults.count
        } else {
            return popularMovies.count
        }
    }

    func getMovie(at index: Int) -> Movie? {
        if !searchResults.isEmpty {
            return searchResults[safe: index]
        } else {
            return popularMovies[safe: index]
        }
    }

}
