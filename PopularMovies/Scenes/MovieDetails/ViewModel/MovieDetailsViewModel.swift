//
//  MovieDetailsViewModel.swift
//  PopularMovies
//
//  Created by jobzella on 12/4/24.
//

import Foundation
class MovieDetailsViewModel {
    private let movieService: MovieService
    private var movieDetails:MovieDetails?
    private var similarMovies: [Movie] = []

    var movieDetailsDidChange: (() -> Void)?
    var similarMovieDetailsDidChange: (() -> Void)?

    var isLoading: ((Bool) -> Void)?

    init(movieService: MovieService = MovieService()) {
        self.movieService = movieService
    }
    
    func fetchMovieDetails(id: Int) {
        
        isLoading?(true)
        movieService.movieDetails(id: id) {[weak self] response, error in

            self?.fetchSimilarMovies(id: id)
            if let response = response {
                
                self?.movieDetails = response
                self?.movieDetailsDidChange?() 
            }

        }
        
    }
    func fetchSimilarMovies(id: Int) {
        
        movieService.fetchSimilarMovies(page: 1, id: id, completion: { response, error in
            
            if let response = response{
                self.similarMovies = response.results ?? []
                self.similarMovieDetailsDidChange?()
            }
            
        })
        
    }

    func getDetails()->MovieDetails?{
        return movieDetails
    }
    func getSimilarMovies()->[Movie]?{
        return similarMovies
    }


}
