//
//  Movie.swift
//  MovieApp
//
//  Created by Sebastian Diaz on 4/3/19.
//  Copyright © 2019 Accenture. All rights reserved.
//

import Foundation
struct Movie {
    var title : String
    var releaseDate : String
    var genres : [Genre]
    var overview: String
    
}

struct MovieViewModel {

    var title : String
    var year : String
    var genres : [String]
    var overview : String
    
    
}
