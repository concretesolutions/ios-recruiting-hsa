//
//  MovieDetailModel.swift
//  ios-recruiting-hsa
//
//  Created on 08-08-19.
//

import Foundation

struct MovieDetailModel {
    let isAdult: Bool
    let backdropPath: String?
    let belongsToCollection: CollectionModel?
    let budget: Int
    let genres: [GenreModel]
    let homepage: String?
    let id: Int
    let imdbId: String?
    let originalLanguage: String
    let originalTitle: String
    let overview: String?
    let popularity: Double
    let posterPath: String?
    let productionCompanies: [ProductionCompanyModel]
    let productionCountries: [ProductionCountryModel]
    let releaseDate: Date?
    let revenue: Int
    let runtime: Int?
    let spokenLanguages: [SpokenLanguageModel]
    let status: String
    let tagline: String?
    let title: String
    let isVideo: Bool
    let voteAverage: Double
    let voteCount: Int
}
