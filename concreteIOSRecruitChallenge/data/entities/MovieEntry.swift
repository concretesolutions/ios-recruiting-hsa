//
//  MovieEntry.swift
//  concreteIOSRecruitChallenge
//
//  Created by Kristian Sthefan Cortes Prieto on 08-02-21.
//

import UIKit

struct MovieEntry {
    var adult: Bool?
    var backdrop_path: String?
    var id: Int?
    var original_language: String?
    var original_title: String?
    var overview: String?
    var popularity: Int?
    var poster_path: String?
    var release_date: String?
    var title: String?
    var video: Bool?
    var vote_average: Int?
    var vote_count: Int?
    
    init(id: Int?, adult: Bool?, backdrop_path: String?, original_language: String?, original_title: String?, overview: String?, popularity: Int?, poster_path: String?, release_date: String?, title: String?, video: Bool?, vote_average: Int?, vote_count: Int?){
        self.id = id
        self.adult = adult
        self.backdrop_path = backdrop_path
        self.original_language = original_language
        self.original_title = original_title
        self.overview = overview
        self.popularity = popularity
        self.poster_path = poster_path
        self.release_date = release_date
        self.title = title
        self.video = video
        self.vote_average = vote_average
        self.vote_count = vote_count
    }
    
    init(_ json: [String:AnyObject]){
        if let data = json["id"] as? Int{ self.id = data }
        if let data = json["adult"] as? Bool{ self.adult = data }
        if let data = json["backdrop_path"] as? String{ self.backdrop_path = data }
        if let data = json["original_language"] as? String{ self.original_language = data }
        if let data = json["original_title"] as? String{ self.original_title = data }
        if let data = json["overview"] as? String{ self.overview = data }
        if let data = json["popularity"] as? Int{ self.popularity = data }
        if let data = json["poster_path"] as? String{ self.poster_path = data }
        if let data = json["release_date"] as? String{ self.release_date = data }
        if let data = json["title"] as? String{ self.title = data }
        if let data = json["video"] as? Bool{ self.video = data }
        if let data = json["vote_average"] as? Int{ self.vote_average = data }
        if let data = json["vote_count"] as? Int{ self.vote_count = data }
    }
    
    static func arrayFromJson(_ json: [Dictionary<String,AnyObject>]?) -> Any? {
        if(json == nil){
            return nil
        }
        var array:[MovieEntry] = []
        
        for data in json!{
            array.append(MovieEntry(data))
        }
    
        return array
    }

}
