//
//  Favourite.swift
//  movie-app-hsa
//
//  Created by training on 03-07-22.
//

import Foundation

struct Favourite: Hashable {
    
    var id: Int
    var name: String
    var image: String
    var releaseDate: String
    var synopsis: String

    func hash(into hasher: inout Hasher) {
        hasher.combine(name)
    }

    static func ==(lhs: Favourite, rhs: Favourite) -> Bool {
        return lhs.id == rhs.id
    }
}
