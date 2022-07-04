//
//  Favorites.swift
//  GetMovieApp
//
//  Created by Training on 04-07-22.
//

import Foundation
import UIKit

class Favorites: Hashable {
    
    //MARK: Properties
    var id : Int
    var overview : String?
    var posterPath : String?
    var releaseDate : String?
    var title : String?
    
    //MARK: Init
    init(id: Int, overiview: String?, posterPath: String?, releaseDate: String?, title: String?){
        self.id = id
        self.overview = overiview
        self.posterPath = posterPath
        self.releaseDate = releaseDate
        self.title = title
    }
    
    //MARK: Methods Hashable
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    static func ==(lhs: Favorites, rhs: Favorites) -> Bool {
        return lhs.id == rhs.id
    }
}
