//
//  MovieDetailsModel.swift
//  PopularMovies
//
//  Created by jobzella on 12/4/24.
//

import Foundation

// MARK: - Movie
struct MovieDetails: Decodable {
    let id: Int?
    let overview: String?
    let releaseDate: String?
    let revenue: Int?
    let status: String?
    let tagline: String?
    let title: String?
    let posterPath: String?

    
    enum CodingKeys: String, CodingKey {
        case id
        case overview
        case releaseDate = "release_date"
        case revenue
        case status
        case tagline
        case title
        case posterPath = "poster_path"
    }
}

struct CollectionViewItem{
    var image:String
    var title:String
}
