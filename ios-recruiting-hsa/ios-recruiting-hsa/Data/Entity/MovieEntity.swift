//
//  MovieEntity.swift
//  ios-recruiting-hsa
//
//  Created on 07-08-19.
//

struct MovieEntity: Codable {
    let voteCount: Int
    let id: Int
    let isVideo: Bool
    let voteAverage: Double
    let title: String
    let popularity: Double
    let posterPath: String?
    let originalLanguage: String
    let originalTitle: String
    let genreIds: [Int]
    let backdropPath: String?
    let isAdult: Bool
    let overview: String
    let releaseDate: String
    
    private enum CodingKeys: String, CodingKey {
        case voteCount = "vote_count"
        case id
        case isVideo = "video"
        case voteAverage = "vote_average"
        case title
        case popularity
        case posterPath = "poster_path"
        case originalLanguage = "original_language"
        case originalTitle = "original_title"
        case genreIds = "genre_ids"
        case backdropPath = "backdrop_path"
        case isAdult = "adult"
        case overview
        case releaseDate = "release_date"
    }
}
