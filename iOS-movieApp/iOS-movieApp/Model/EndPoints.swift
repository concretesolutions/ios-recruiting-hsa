//
//  EndPoints.swift
//  iOS-movieApp
//
//  Created by alvaro.concha on 01-07-22.
//

import Foundation

struct Endpoints{
    static private let api_key = "api_key=83066dbfe6628674f496b154748650c5"
    static var language = "es-MX"
    static let images = "https://image.tmdb.org/t/p/w500"
    static let domain = "https://api.themoviedb.org/3/"
    
    
    static let genres = "\(domain)genre/movie/list?\(api_key)&language=\(language)"
    static let popularMovies = "\(domain)movie/popular?\(api_key)&language=\(language)"
    

}
