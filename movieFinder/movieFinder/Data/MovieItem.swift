//
//  Movie.swift
//  movieFinder
//
//  Created by Francisco Zuniga De Spirito on 28-09-22.
//

import Foundation

struct MovieItem {
    let id: UUID
    let imageURL: String
    let name: String
    let releaseDate: String
    let genres: [String]
    let description : String
}
