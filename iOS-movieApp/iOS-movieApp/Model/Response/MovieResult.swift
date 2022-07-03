//
//  MovieResult.swift
//  iOS-movieApp
//
//  Created by alvaro.concha on 01-07-22.
//

import Foundation

struct MovieResult : Codable{
    
    let adult : Bool
    let backdrop_path : String
    let genre_ids : [Int]
    let id : Int
    let original_language : String
    let original_title : String
    let overview : String
    let popularity : Double
    let poster_path : String
    let release_date : String
    let title : String
    let video : Bool
    let vote_average : Double
    let vote_count : Int
    
}
