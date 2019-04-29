//
//  MovieCollectionEntity.swift
//  Concrete-Movies
//
//  Created by Audel Dugarte on 4/29/19.
//  Copyright © 2019 Audel Dugarte. All rights reserved.
//

import Foundation

struct MovieCollectionEntity: Codable {
    let collectionId: Int
    let name: String
    let posterPath: String
    let backdropPath: String
    
    private enum CodingKeys: String, CodingKey {
        case collectionId = "id"
        case name
        case posterPath = "poster_path"
        case backdropPath = "backdrop_path"
    }
}

/*
 {
 "id": 86311,
 "name": "The Avengers Collection",
 "poster_path": "/qJawKUQcIBha507UahUlX0keOT7.jpg",
 "backdrop_path": "/zuW6fOiusv4X9nnW3paHGfXcSll.jpg"
 }
 */
