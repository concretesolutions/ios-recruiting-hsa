//
//  Genre.swift
//  Movies
//
//  Created by Pedro on 23-07-24.
//

import Foundation

struct Genre: Identifiable, Decodable, Equatable {
    let id: Int
    let name: String
}
