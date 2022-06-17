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
    let results:[Movie]
}

//MARK: -  List Model
struct Movie: Codable{
    let title: String
    let poster_path: String
    
}
