//
//  MovieListAPIData.swift
//  movieFinder
//
//  Created by Francisco Zuniga De Spirito on 30-09-22.
//

import Foundation

struct movieListType: Decodable {
    let original_title: String
    let id: Int
    let poster_path: String
}
public struct popularMoviesResponseType: Decodable {
    let page: Int
    let results: [movieListType]
}
