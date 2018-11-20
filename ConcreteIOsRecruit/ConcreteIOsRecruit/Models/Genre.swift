//
//  Genre.swift
//  ConcreteIOsRecruit
//
//  Created by Matías Contreras Selman on 11/20/18.
//  Copyright © 2018 Matias Contreras. All rights reserved.
//

import Foundation

struct GenreAPIResponse: Codable{
    var genres: [Genre]
}

struct Genre: Codable, Equatable{
    var id: Int
    var name: String
    
    static func ==(lhs: Genre, rhs: Genre) -> Bool {
        return lhs.id == rhs.id
    }
}
