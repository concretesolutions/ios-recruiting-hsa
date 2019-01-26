//
//  MovieDetail.swift
//  MovieApp
//
//  Created by luis.a.rosas.arce on 25/01/19.
//  Copyright © 2019 luis.a.rosas.arce. All rights reserved.
//

import UIKit
import SwiftyJSON

class MovieDetail: NSObject {
    var movieID : String = ""
    var movieOverview : String = ""
    var movieLanguage : String = ""
    var movieTitle : String = ""
    var movieAdult : Bool = false
    var movieReleaseDate : String = ""
    var movieBackdropPath : String = ""
    var movieVoteAverage : Float = 0.0
    var movieVoteCount : Int = 0
    var genresMovie = [GenreMovie]()
    
    //Other parameters
    var movieBelongToCollection : String?
    var movieRevenue : String = ""
    var movieTagLine : String = ""
    var movieProductionCompanies : String?
    var moviePosterPath : String = ""
    var movieHomePage : String = ""
    var moviePopularity : Float = 0.0
    var movieRuntime : Int = 0
    var movieProductionCountries : String?
    var movieIMDBID : String = ""
    
    
    override init() {
        
    }
    
    convenience init(json : JSON) {
        self.init()
        movieID = String(describing : json["id"])
        movieOverview = String(describing: json["overview"])
        movieTitle = String(describing: json["original_title"])
        movieBackdropPath = APIManager.pathImage + String(describing: json["backdrop_path"])
        movieReleaseDate = String(describing: json["release_date"])
        
        let genrerJson = json["genres"]
        for (_,subJson):(String, JSON) in genrerJson {
            self.genresMovie.append(GenreMovie(json: subJson))
        }
    }
    
    
    func getGenresMovieString() -> String {
        var genres : String = ""
        var firstElementAdded = false
        
        for genrer in self.genresMovie {
            var separator = ""
            if firstElementAdded {
                separator = ", "
            }
            genres = genres + separator + genrer.genreName
            firstElementAdded = true
        }
        
        return genres

    }
    
    func getYearFromMovie() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-mm-dd"
        
        let date = dateFormatter.date(from: self.movieReleaseDate)
        
        let calendar = Calendar.current
        return String(calendar.component(.year, from: date!))
        
    }
    
    
}
