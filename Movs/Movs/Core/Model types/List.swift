//
//  List.swift
//  TMDB Reloaded
//
//  Created by Miguel Duran on 1/4/19.
//  Copyright © 2018 Miguel Duran. All rights reserved.
//

import Foundation

struct List<T: Decodable> {
    let page: Int
    let totalResults: Int
    let totalPages: Int
    let results: [T]
}

extension List: Decodable {
    enum CodingKeys: String, CodingKey {
        case page
        case totalResults = "total_results"
        case totalPages = "total_pages"
        case results
    }
}
