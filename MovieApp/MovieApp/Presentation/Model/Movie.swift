//
//  Movie.swift
//  MovieApp
//
//  Created by luis.a.rosas.arce on 24/01/19.
//  Copyright © 2019 luis.a.rosas.arce. All rights reserved.
//

import UIKit
import SwiftyJSON

class Movie: NSObject {
    
    var movieID : String = ""
    var movieOverview : String = ""
    var movieLanguage : String = ""
    var movieTitle : String = ""
    var movieAdult : Bool = false
    var movieReleaseDate : String = ""
    var movieBackdropPath : String = ""
    var movieVoteAverage : Float = 0.0
    var movieVoteAccount : Int = 0
    
    override init() {
        
    }
    
    convenience init(json : JSON) {
        self.init()
        movieID = String(describing : json["id"])
        movieOverview = String(describing: json["overview"])
        movieTitle = String(describing: json["original_title"])
        movieBackdropPath = APIManager.pathImage + String(describing: json["backdrop_path"])
    }
    

}
