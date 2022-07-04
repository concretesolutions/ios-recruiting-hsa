//
//  Movie.swift
//  GetMovieApp
//
//  Created by Training on 03-07-22.
//

import Foundation

struct Movie: Hashable {
    
    //MARK: Propierties
    var adult: Bool?
    var backdropPath : String?
    var genreIDS: [Int]
    var id : Int?
    var originalLanguage : String?
    var originalTitle : String?
    var overview : String?
    var popularity : Double?
    var posterPath : String?
    var releaseDate : String?
    var title : String?
    var video : Bool?
    var voteAverage : Double?
    var voteCount : Int?

    //MARK: Methods Hashable
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    
    static func ==(lhs: Movie, rhs: Movie) -> Bool {
        return lhs.id == rhs.id
    }
}
