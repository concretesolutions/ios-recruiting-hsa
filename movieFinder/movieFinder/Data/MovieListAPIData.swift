//
//  MovieListAPIData.swift
//  movieFinder
//
//  Created by Francisco Zuniga De Spirito on 30-09-22.
//

import Foundation

struct movieListType: Decodable {
    let original_title: String,
        id: Int,
        poster_path: String
}
public struct popularMoviesResponseType: Decodable {
    let page: Int,
        results: [movieListType]
}
