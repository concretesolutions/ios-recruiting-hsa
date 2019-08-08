//
//  MovieDetailEntity.swift
//  ios-recruiting-hsa
//
//  Created on 08-08-19.
//

struct MovieDetailEntity: Codable {
    let isAdult: Bool
    let backdropPath: String?
    let belongsToCollection: [CollectionEntity]?
    let budget: Int
    let genres: [GenreEntity]
    let homepage: String?
    let id: Int
    let imdbId: String?
    let originalLanguage: String
    let originalTitle: String
    let overview: String?
    let popularity: Double
    let posterPath: String?
    let productionCompanies: [ProductionCompanyEntity]
    let productionCountries: [ProductionCountryEntity]
    let releaseDate: String
    let revenue: Int
    let runtime: Int?
    let spokenLanguages: [SpokenLanguageEntity]
    let status: String
    let tagline: String?
    let title: String
    let isVideo: Bool
    let voteAverage: Double
    let voteCount: Int
    
    private enum CodingKeys: String, CodingKey {
        case isAdult = "adult"
        case backdropPath = "backdrop_path"
        case belongsToCollection = "belongs_to_collection"
        case budget
        case genres
        case homepage
        case id
        case imdbId = "imdb_id"
        case originalLanguage = "original_language"
        case originalTitle = "original_title"
        case overview
        case popularity
        case posterPath = "poster_path"
        case productionCompanies = "production_companies"
        case productionCountries = "production_countries"
        case releaseDate = "release_date"
        case revenue
        case runtime
        case spokenLanguages = "spoken_languages"
        case status
        case tagline
        case title
        case isVideo = "video"
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
    }
}
