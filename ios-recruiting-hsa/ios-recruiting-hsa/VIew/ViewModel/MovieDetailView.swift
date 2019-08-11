//
//  MovieDetailView.swift
//  ios-recruiting-hsa
//
//  Created on 10-08-19.
//

import Foundation

struct MovieDetailView {
    let isAdult: Bool
    let backdropPath: String?
    let belongsToCollection: CollectionView?
    let budget: Int
    let genres: [GenreView]
    let homepage: String?
    let id: Int
    let imdbId: String?
    let originalLanguage: String
    let originalTitle: String
    let overview: String?
    let popularity: Double
    let posterPath: String?
    let productionCompanies: [ProductionCompanyView]
    let productionCountries: [ProductionCountryView]
    let releaseDate: Date?
    let revenue: Int
    let runtime: Int?
    let spokenLanguages: [SpokenLanguageView]
    let status: String
    let tagline: String?
    let title: String
    let isVideo: Bool
    let voteAverage: Double
    let voteCount: Int
}
