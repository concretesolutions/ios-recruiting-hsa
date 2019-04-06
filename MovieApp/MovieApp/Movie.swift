//
//  Movie.swift
//  MovieApp
//
//  Created by Sebastian Diaz on 4/3/19.
//  Copyright © 2019 Accenture. All rights reserved.
//

import Foundation
import Realm
import RealmSwift

class IntObject: Object {
    @objc dynamic var value : Int = 0
    
    convenience init(_ newValue: Int) {
        self.init()
        value = newValue
    }
    
    required init() {
        super.init()
    }
    
    required init(realm: RLMRealm, schema: RLMObjectSchema) {
        super.init(realm: realm, schema: schema)
    }
    
    required init(value: Any, schema: RLMSchema) {
        super.init(value: value, schema: schema)
    }
    
}

class Movie : Object, Decodable{
    enum Property: String {
        case id
    }
    
    
    @objc dynamic var id : Int = 0
    @objc dynamic var title : String = ""
    @objc dynamic var releaseDate : String = ""
    dynamic var genres : List<IntObject> = List.init()
    @objc dynamic var overview: String = ""
    @objc dynamic var imagePath : String = ""
    
    convenience init(id: Int, title:String, releaseDate: String, genres:[Int], overview: String, imagePath : String) {
        self.init()
        self.id = id
        self.title = title
        self.releaseDate = releaseDate
        for id in genres {
            self.genres.append(IntObject.init(id))
        }
        self.overview = overview
        self.imagePath = imagePath
    }
    
    required init() {
        super.init()
    }
    
    override static func primaryKey() -> String? {
        return "id"
    }
    
    
    enum MovieKeys : String,CodingKey {
        case id
        case title
        case releaseDate = "release_date"
        case genres = "genre_ids"
        case overview = "overview"
        case imagePath = "poster_path"
    }
    
    required convenience init(from decoder:Decoder) throws{
        let container = try decoder.container(keyedBy: MovieKeys.self)
        let id = try container.decode(Int.self, forKey: .id)
        let title = try container.decode(String.self, forKey: .title)
        let release = try container.decode(String.self, forKey: .releaseDate)
        let genres = try container.decode([Int].self, forKey: .genres)
        let overview = try container.decode(String.self, forKey: .overview)
        let imagePath = try container.decode(String.self, forKey: .imagePath)
        
        self.init(id: id, title: title, releaseDate: release, genres: genres, overview: overview,imagePath: imagePath)
        
    }
    
    required init(realm: RLMRealm, schema: RLMObjectSchema) {
        super.init(realm: realm, schema: schema)
    }
    
    required init(value: Any, schema: RLMSchema) {
        super.init(value: value, schema: schema)
    }
    

}

struct MovieViewModel {
    var id : Int
    var title : String
    var year : String
    var genres : [Genre]
    var overview : String
    var imagePath : String

}
