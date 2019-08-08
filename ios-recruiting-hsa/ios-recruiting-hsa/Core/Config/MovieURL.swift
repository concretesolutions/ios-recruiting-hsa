//
//  MovieURL.swift
//  ios-recruiting-hsa
//
//  Created on 07-08-19.
//

enum MovieURL {
    static let imageUrl = "https://image.tmdb.org/t/p/w500"
    
    enum Prod: String {
        case url = "https://api.themoviedb.org/3/movie"
        case apiKey = "&api_key"//TODO register apikey
    }
}
