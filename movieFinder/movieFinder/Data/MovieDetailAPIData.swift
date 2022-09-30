//
//  MovieDetailAPIData.swift
//  movieFinder
//
//  Created by Francisco Zuniga De Spirito on 30-09-22.
//

import Foundation

public struct Genres: Decodable {
    let id: Int
    let name: String
}

public struct movieDetailType: Decodable {
    let original_title: String
    let id: Int
    let backdrop_path: String
    let release_date: String
    let genres: [Genres]
    let overview: String
}
