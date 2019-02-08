//
//  MovieType.swift
//  AccentureChallenge
//
//  Created by Jaime on 2/4/19.
//  Copyright © 2019 Jaime. All rights reserved.
//

import RealmSwift

class Genre: Object {
    
    @objc dynamic var id: Int = -1
    @objc dynamic var name: String = ""
    
    override static func primaryKey() -> String? {
        
        return "id"
    }
}
