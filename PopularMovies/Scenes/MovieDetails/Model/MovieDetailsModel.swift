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
struct MovieCast: Codable {
    let adult: Bool?
    let gender: Int?
    let id: Int?
    let knownForDepartment: String?
    let name: String?
    let originalName: String?
    let popularity: Double?
    let profilePath: String?
    let castId: Int?
    let character: String?
    let creditId: String?
    let order: Int?
    
    enum CodingKeys: String, CodingKey {
        case adult
        case gender
        case id
        case knownForDepartment = "known_for_department"
        case name
        case originalName = "original_name"
        case popularity
        case profilePath = "profile_path"
        case castId = "cast_id"
        case character
        case creditId = "credit_id"
        case order
    }
}
struct MovieCrew: Codable {
    let adult: Bool?
    let gender: Int?
    let id: Int?
    let knownForDepartment: String?
    let name: String?
    let originalName: String?
    let popularity: Double?
    let profilePath: String?
    let creditId: String?
    let department: String?
    let job: String?
    
    enum CodingKeys: String, CodingKey {
        case adult
        case gender
        case id
        case knownForDepartment = "known_for_department"
        case name
        case originalName = "original_name"
        case popularity
        case profilePath = "profile_path"
        case creditId = "credit_id"
        case department
        case job
    }
}

struct MovieCastResponse:Codable{
    var cast:[MovieCast]?
    var crew:[MovieCrew]?
}
