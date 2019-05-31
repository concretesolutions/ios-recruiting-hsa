//
//  PopularResponse.swift
//  ios-recruiting-hsa
//
//  Created by Hans Fehrmann on 5/30/19.
//  Copyright © 2019 Hans Fehrmann. All rights reserved.
//

import Foundation

struct PopularMoviesApiRepsonse: Codable {

    enum CodingKeys: String, CodingKey {
        case page
        case results
        case totalPages = "total_pages"
    }

    let page: Int
    let results: [PopularMovie]
    let totalPages: Int

}
