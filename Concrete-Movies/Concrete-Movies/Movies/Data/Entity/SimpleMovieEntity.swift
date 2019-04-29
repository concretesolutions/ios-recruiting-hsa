//
//  MovieEntity.swift
//  Concrete-Movies
//
//  Created by Audel Dugarte on 4/25/19.
//  Copyright © 2019 Audel Dugarte. All rights reserved.
//
struct SimpleMovieEntity: Codable{
    let posterPath: String
    let adult: Bool
    let overview: String
    let releaseDate: String
    let genreIds: [Int]
    let movieId: Int
    let originalTitle: String
    let originalLanguage: String
    let title: String
    let backdropPath: String
    let popularity: Double
    let voteCount: Int
    let video: Bool
    let voteAverage: Double
    
    private enum CodingKeys: String, CodingKey {
        case posterPath = "poster_path"
        case adult
        case overview
        case releaseDate = "release_date"
        case genreIds = "genre_ids"
        case movieId = "id"
        case originalTitle = "original_title"
        case originalLanguage = "original_language"
        case title
        case backdropPath = "backdrop_path"
        case popularity
        case voteCount = "vote_count"
        case video
        case voteAverage = "vote_average"
    }
}

/*
{
    "poster_path": "/e1mjopzAS2KNsvpbpahQ1a6SkSn.jpg",
    "adult": false,
    "overview": "From DC Comics comes the Suicide Squad, an antihero team of incarcerated supervillains who act as deniable assets for the United States government, undertaking high-risk black ops missions in exchange for commuted prison sentences.",
    "release_date": "2016-08-03",
    "genre_ids": [
    14,
    28,
    80
    ],
    "id": 297761,
    "original_title": "Suicide Squad",
    "original_language": "en",
    "title": "Suicide Squad",
    "backdrop_path": "/ndlQ2Cuc3cjTL7lTynw6I4boP4S.jpg",
    "popularity": 48.261451,
    "vote_count": 1466,
    "video": false,
    "vote_average": 5.91
}
*/
