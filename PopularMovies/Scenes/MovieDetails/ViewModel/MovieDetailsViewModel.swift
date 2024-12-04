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
    private var moviecasts:MovieCastResponse?

    var movieDetailsDidChange: (() -> Void)?
    var similarMovieDetailsDidChange: (() -> Void)?
    var movieCastsDidChange: (() -> Void)?

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
        
        movieService.fetchSimilarMovies(page: 1, id: id, completion: {[weak self] response, error in
            self?.fetchMovieCasts(id: id)
            if let response = response{
                self?.similarMovies = response.results ?? []
                self?.similarMovieDetailsDidChange?()
            }
            
        })
        
    }
    func fetchMovieCasts(id: Int) {
        
        movieService.fetchCredits(page: 1, id: id, completion: { response, error in
            
            if let response = response{
                self.moviecasts = response
                self.movieCastsDidChange?()
            }
            
        })
        
    }


    func getDetails()->MovieDetails?{
        return movieDetails
    }
    func getSimilarMovies()->[Movie]?{
        return similarMovies
    }
    private  func getMovieCasts()->MovieCastResponse?{
        return moviecasts
    }
    private func getMovieActors()->[MovieCast]?{
        return getMovieCasts()?.cast!.filter({$0.knownForDepartment == "Acting"})
    }
    private func getMovieDirectors()->[MovieCrew]?{
        return getMovieCasts()?.crew!.filter({$0.knownForDepartment == "Directing"})
    }
    func getTopMovieActors()->[MovieCast]?{
        guard let actors = getMovieActors() else{return nil}
        let uniquePeople = Array(Dictionary(grouping: actors, by: { $0.id }).values.compactMap { $0.first })

        // Sort the actors list by popularity in descending order
        let sortedPeople = uniquePeople.sorted { $0.popularity! > $1.popularity! }

        // Get the top 5 actors
        let topActors = Array(sortedPeople.prefix(5))

        return topActors
    }
    func getTopMovieDirectors()->[MovieCrew]?{
        guard let directors = getMovieDirectors() else{return nil}

        let uniqueDirectors = Array(Dictionary(grouping: directors, by: { $0.id }).values.compactMap { $0.first })

        // Sort the directors list by popularity in descending order
        let sortedDirectors = uniqueDirectors.sorted { $0.popularity! > $1.popularity! }

        // Get the top 5 actors
        let topDirectors = Array(sortedDirectors.prefix(5))

        return topDirectors

    }
    





}
