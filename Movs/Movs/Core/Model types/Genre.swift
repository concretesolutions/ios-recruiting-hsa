//
//  Genre.swift
//  Movs
//
//  Created by Miguel Duran on 1/8/19.
//  Copyright © 2019 Miguel Duran. All rights reserved.
//

import Foundation

struct Genre: Decodable {
    let id: Int
    let name: String
}

struct GenresList: Decodable {
    let genres:[Genre]
}
