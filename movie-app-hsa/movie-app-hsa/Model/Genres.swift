//
//  Genres.swift
//  movie-app-hsa
//
//  Created by training on 03-07-22.
//

import Foundation

struct Genres: Hashable {
    
    var id: Int
    var name: String

    func hash(into hasher: inout Hasher) {
        hasher.combine(name)
    }

    static func ==(lhs: Genres, rhs: Genres) -> Bool {
        return lhs.id == rhs.id
    }
}
