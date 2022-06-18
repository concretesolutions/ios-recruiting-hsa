//
//  S.swift
//  MoviesApp
//
//  Created by gustavo.salazar on 17/06/22.
//

import Foundation
import UIKit

//MARK: - Represent the JSON https://api.themoviedb.org/3/movie/popular?
struct Movies: Codable{
    let page: Int
    var results:[Movie]
}

//MARK: -  List Model
struct Movie: Codable{
    let title: String
    let poster_path: String
    let genre_ids:[Int]
    let overview:String
    let release_date:Date
    
}

struct Genre: Codable{
    let id: Int
    let name: String
}
