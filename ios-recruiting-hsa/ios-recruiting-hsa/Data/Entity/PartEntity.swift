//
//  PartEntity.swift
//  ios-recruiting-hsa
//
//  Created on 8/8/19.
//

struct PartEntity: Codable {
    let isAdult: Bool
    let backdropPath: String?
    let genreIds: [Int]
    let id: Int
    let originalLanguage: String
    let originalTitle: String
    let overview: String
    let releaseDate: String
    let posterPath: String
    let popularity: Double
    let title: String
    let isVideo: Bool
    let voteAverage: Double
    let voteCount: Int
    
    private enum CodingKeys: String, CodingKey {
        case isAdult = "adult"
        case backdropPath = "backdrop_path"
        case genreIds = "genre_ids"
        case id
        case originalLanguage = "original_language"
        case originalTitle = "original_title"
        case overview
        case releaseDate = "release_date"
        case posterPath = "poster_path"
        case popularity
        case title
        case isVideo = "video"
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
    }
}
