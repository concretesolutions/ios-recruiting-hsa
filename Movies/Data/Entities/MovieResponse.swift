//
//  MovieResponse.swift
//  Movies
//
//  Created by Pedro on 23-07-24.
//

import Foundation

struct MovieResponse: Decodable {
    let results: [Movie]
}
