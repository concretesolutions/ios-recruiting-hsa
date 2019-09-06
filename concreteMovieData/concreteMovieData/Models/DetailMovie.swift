//
//  DetailMovie.swift
//  concreteMovieData
//
//  Created by Christopher Parraguez on 9/5/19.
//  Copyright © 2019 Christopher Parraguez. All rights reserved.
//

import Foundation
import ObjectMapper

class DetailMovie:Mappable{

    var backdrop_path: String!
    var original_title: String!
    var release_date: String!
    var genres: [GenereMovie]!
    var overview: String!
    var title: String!
    var poster_path: String!
    
    required init?(map: Map) {
    }
    
    func mapping(map: Map) {
        backdrop_path <- map["backdrop_path"]
        original_title <- map["original_title"]
        release_date <- map["release_date"]
        genres <- map["genres"]
        overview <- map["overview"]
        title <- map["title"]
        poster_path <- map["poster_path"]
    }

    func genresString() -> String {
        var genereString = genres[0].name
        if genres.count > 1 {
            for index in 1..<genres.count {
                let separator = index < genres.count-1 ? ", " : " & "
                genereString! += separator + genres[index].name
            }
        }
        return genereString!
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
class GenereMovie:Mappable{
    var name:String!
    
    required init?(map: Map) {
    }
    
    func mapping(map: Map) {
        name <- map["name"]
    }
    
    
}
