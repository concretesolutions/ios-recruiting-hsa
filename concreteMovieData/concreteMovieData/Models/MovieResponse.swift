//
//  Movie.swift
//  concreteMovieData
//
//  Created by Christopher Parraguez on 9/5/19.
//  Copyright © 2019 Christopher Parraguez. All rights reserved.
//

import Foundation
import ObjectMapper

class MovieResponse: Mappable{
    
    var popularity: NSNumber!
    var poster_path: String!
    var id: NSNumber!
    var original_language: String!
    var original_title: String!
    var title: String!
    var vote_average: NSNumber!
    var overview: String!
    var release_date: String!
    
    required init?(map: Map) {
    }
    
    init(json: [String: Any]){
        self.popularity = json["popularity"] as? NSNumber
        self.poster_path = json["poster_path"] as? String
        self.id = json["id"] as? NSNumber
        self.original_language = json["original_language"] as? String
        self.original_title = json["original_title"] as? String
        self.title = json["title"] as? String
        self.vote_average = json["vote_average"] as? NSNumber
        self.overview = json["overview"] as? String
        self.release_date = json["release_date"] as? String
    }
    func mapping(map: Map) {
        popularity <- map["popularity"]
        poster_path <- map["poster_path"]
        id <- map["id"]
        original_language <- map["original_language"]
        original_title <- map["original_title"]
        title <- map["title"]
        vote_average <- map["vote_average"]
        overview <- map["overview"]
        release_date <- map["release_date"]
    }
    func encode(with aCoder: NSCoder){
        aCoder.encode(self.popularity, forKey: "popularity")
        aCoder.encode(self.poster_path, forKey: "poster_path")
        aCoder.encode(self.id, forKey: "id")
        aCoder.encode(self.original_language, forKey: "original_language")
        aCoder.encode(self.original_title, forKey: "original_title")
        aCoder.encode(self.title, forKey: "title")
        aCoder.encode(self.vote_average, forKey: "vote_average")
        aCoder.encode(self.overview, forKey: "overview")
        aCoder.encode(self.release_date, forKey: "release_date")
    }
    
    required init?(coder aDecoder: NSCoder){
        self.popularity = aDecoder.decodeObject(forKey: "popularity") as? NSNumber
        self.poster_path = aDecoder.decodeObject(forKey: "poster_path") as? String
        self.id = aDecoder.decodeObject(forKey: "id") as? NSNumber
        self.original_language = aDecoder.decodeObject(forKey: "original_language") as? String
        self.original_title = aDecoder.decodeObject(forKey: "original_title") as? String
        self.title = aDecoder.decodeObject(forKey: "title") as? String
        self.vote_average = aDecoder.decodeObject(forKey: "vote_average") as? NSNumber
        self.overview = aDecoder.decodeObject(forKey: "overview") as? String
        self.release_date = aDecoder.decodeObject(forKey: "release_date") as? String
    }
    func getYearToDateString() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        guard let date = dateFormatter.date(from: self.release_date) else {
            fatalError()
        }
        dateFormatter.dateFormat = "yyyy"
        let newDate = dateFormatter.string(from: date)
        return newDate
    }
}

class ResultResponse:Mappable{
    var page: NSNumber!
    var total_results: NSNumber!
    var total_pages: NSNumber!
    var results: [MovieResponse]!
    
    required init?(map: Map) {}
    func mapping(map: Map) {
        page <- map["page"]
        total_results <- map["total_results"]
        total_pages <- map["total_pages"]
        results <- map["results"]
    }
}

