//
//  MovieDetailAPIData.swift
//  movieFinder
//
//  Created by Francisco Zuniga De Spirito on 30-09-22.
//

import Foundation

public struct Genres: Decodable {
    let id: Int,
        name: String
}

public struct movieDetailType: Decodable {
    let original_title: String,
        id: Int, backdrop_path: String,
        release_date: String,
        genres: [Genres],
        overview: String
}
