//
//  Movie.swift
//  ios-recruiting-hsa
//
//  Created by Hans Fehrmann on 5/27/19.
//  Copyright © 2019 Hans Fehrmann. All rights reserved.
//

import Foundation

struct PopularMovie: Codable {

    enum CodingKeys: String, CodingKey {
        case id
        case title
        case overview
        case releaseDate = "release_date"
        case posterPath = "poster_path"
        case genreIds = "genre_ids  "
    }

    let id: Int?
    let title: String?
    let releaseDate: String?
    let overview: String?
    let posterPath: String?
    let genreIds: [Genre]?

}
