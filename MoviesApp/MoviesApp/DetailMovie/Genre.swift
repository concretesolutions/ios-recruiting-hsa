//
//  Genre.swift
//  MoviesApp
//
//  Created by gustavo.salazar on 18/06/22.
//

import Foundation

struct Genres: Codable{
    var genres:[Genre]
}

//MARK: - Genre
struct Genre: Codable{
    let id: Int
    let name: String
}
