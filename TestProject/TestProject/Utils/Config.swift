//
//  Config.swift
//  TestProject
//
//  Created by Felipe S Vergara on 20-10-18.
//  Copyright © 2018 MyOwnCompany. All rights reserved.
//

import Foundation

class Config{
    private static let apiKey       = "34738023d27013e6d1b995443764da44"
    private static let baseDomain   = "https://api.themoviedb.org"
    public static let posterPathBase = "http://image.tmdb.org/t/p/w500"
    
    private struct Endpoints{
        static let movies         = "/3/movie/popular?api_key=%@"
        static let genres         = "/3/genre/movie/list?api_key=%@"
    }
    
    public class func moviesUrl() -> String{
        return "\(Config.baseDomain)\(String(format: Config.Endpoints.movies, Config.apiKey))"
    }
    
    public class func genresUrl() -> String{
        return "\(Config.baseDomain)\(String(format: Config.Endpoints.genres, Config.apiKey))"
    }
}


//Enums
enum ColorName :String{
    case DeepBlue = "DeepBlue"
    case DarkYellow = "DarkYellow"
}




