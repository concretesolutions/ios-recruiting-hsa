//
//  Movie.swift
//  AccentureChallenge
//
//  Created by Jaime on 2/4/19.
//  Copyright © 2019 Jaime. All rights reserved.
//

import RealmSwift

class Movie: Object {
    
    @objc dynamic var id: Int = -1
    @objc dynamic var name: String = ""
    var genres = List<Genre>()
    @objc dynamic var movieDescription: String = ""
    @objc dynamic var pictureURL: String = ""
    @objc dynamic var isFavorite: Bool = false
    @objc dynamic var date: Date = Date()

    
    override static func primaryKey() -> String? {
        
        return "id"
        
    }
}
