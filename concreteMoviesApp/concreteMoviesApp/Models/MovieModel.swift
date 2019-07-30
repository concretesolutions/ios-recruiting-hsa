//
//  MovieModel.swift
//  concreteMoviesApp
//
//  Created by Nebraska Melendez on 7/26/19.
//  Copyright © 2019 Nebraska Melendez. All rights reserved.
//

import Foundation

struct  MovieModel : Codable {
    
    let vote_count : Int
    let id :Int
    let video : Bool
    let vote_average : Double
    let title : String
    let popularity : Double
    let poster_path : String
    let adult : Bool
    let overview : String
    let release_date : String?
    let genre_ids : [Int]
    let original_title : String?
    let original_language : String?
    let backdrop_path : String?
    
    
    //MARK: Funcs
    
    func getImageFullSize() -> URL?{
        return URL(string:"https://image.tmdb.org/t/p/w500\(poster_path)")
    }
    
    func getImageThumbnail() -> URL?{
        return URL(string:"https://image.tmdb.org/t/p/w185\(poster_path)")
    }
    
    func getPrettyGenreList(of list:[GenreModel]) -> String{
        
        let filterList = list.filter{genre_ids.contains($0.id)}
        var result: String = ""
        
        for genre in  filterList{
            result = "\(result) \(genre.name)"
        }
        
        return result
    }
}


