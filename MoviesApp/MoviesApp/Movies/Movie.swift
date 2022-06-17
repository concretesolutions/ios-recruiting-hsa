//
//  S.swift
//  MoviesApp
//
//  Created by gustavo.salazar on 17/06/22.
//

import Foundation
import UIKit

struct Movies: Codable{
    let page: Int
    let results:[Movie]
}

struct Movie: Codable{
    let title: String
    let poster_path: String
    
}
