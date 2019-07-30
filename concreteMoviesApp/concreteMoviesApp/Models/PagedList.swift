//
//  PagedList.swift
//  concreteMoviesApp
//
//  Created by Nebraska Melendez on 7/26/19.
//  Copyright © 2019 Nebraska Melendez. All rights reserved.
//

import Foundation

struct PagedList<T:Codable>: Codable{
    
    let page: Int
    let results:[T]
}

struct GenresList<T: Codable>: Codable {
    let genres: [T]
}
