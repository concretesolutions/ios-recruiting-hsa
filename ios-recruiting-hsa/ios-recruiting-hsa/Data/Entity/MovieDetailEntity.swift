//
//  MovieDetailEntity.swift
//  ios-recruiting-hsa
//
//  Created on 08-08-19.
//

struct MovieDetailEntity {
    let isAdult: Bool
    let backdrop_path: String?
//    "belongs_to_collection:null
    let budget: Int
    let genres: [GenreEntity]
    let homepage: String?
    let id: Int
    let imdb_id: String?
    let original_language: String
    let original_title: String
    let overview: String?
    let popularity: Double
    let poster_path: String?
    let production_companies: [ProductionCompanyEntity]
    let production_countries: [ProductionCountryEntity]
    let release_date: String
    let revenue: Int
    let runtime: Int?
    let spoken_languages: [SpokenLanguageEntity]
    let status: String
    let tagline: String?
    let title: String
    let video: Bool
    let vote_average: Double
    let vote_count: Int
    
    private enum CodingKeys: String, CodingKey {
        case isAdult = "adult"
        case backdropPath = "backdrop_path"
//        case belongsToCollection = "belongs_to_collection"
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
        case release_date
        case revenue
        case runtime
        case spokenLanguages = "spoken_languages"
        case status
        case tagline
        case title
        case video
        case voteAverage = "voteAverage"
        case voteCount = "vote_count"
    }
}
