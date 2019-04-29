//
//  MovieDetailEntity.swift
//  Concrete-Movies
//
//  Created by Audel Dugarte on 4/28/19.
//  Copyright © 2019 Audel Dugarte. All rights reserved.
//

struct MovieDetailEntity: Codable {
    let adult: Bool
    let backDropPath: String
    let belongsToColection: MovieCollectionEntity?
    let budget: Double
    let genres: [GenreEntity]
    let homepage: String
    let movieId: Int
    let imdbId: String
    let originalLanguage: String
    let originalTitle: String
    let overview: String
    let popularity: Float
    let posterPath: String?
    let productionCompanies: [ProductionCompanyEntity]
    let productionCountries: [ProductionCountryEntity]
    let releaseDate: String
    let revenue: Double
    let runtime: Int
    let spokenLanguages: [SpokenLanguageEntity]
    let status: String
    let tagline: String
    let title: String
    let video: Bool
    let voteAverage: Float
    let voteCount: Int
    
    private enum CodingKeys: String, CodingKey {
        case adult
        case backDropPath = "backdrop_path"
        case belongsToColection = "belongs_to_collection"
        case budget
        case genres
        case homepage
        case movieId = "id"
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
        case video
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
    }
}
