//
//  Movie.swift
//  MovieApp
//
//  Created by Sebastian Diaz on 4/3/19.
//  Copyright © 2019 Accenture. All rights reserved.
//

import Foundation

struct Movie : Decodable{
    var id : Int64
    var title : String
    var releaseDate : String
    var genres : [Int]
    var overview: String
    
    init(id: Int64, title:String, releaseDate: String, genres:[Int], overview: String) {
        self.id = id
        self.title = title
        self.releaseDate = releaseDate
        self.genres = genres
        self.overview = overview
    }
    
    
    
    enum MovieKeys : String,CodingKey {
        case id
        case title
        case releaseDate = "release_date"
        case genres = "genre_ids"
        case overview = "overview"
    }
    
    init(from decoder:Decoder) throws{
        let container = try decoder.container(keyedBy: MovieKeys.self)
        let id = try container.decode(Int64.self, forKey: .id)
        let title = try container.decode(String.self, forKey: .title)
        let release = try container.decode(String.self, forKey: .releaseDate)
        let genres = try container.decode([Int].self, forKey: .genres)
        let overview = try container.decode(String.self, forKey: .overview)
        
        self.init(id: id, title: title, releaseDate: release, genres: genres, overview: overview)
        
    }
    
    
}

struct MovieViewModel {
    var id : Int64
    var title : String
    var year : String
    var genres : [Genre]
    var overview : String
    
    
}
