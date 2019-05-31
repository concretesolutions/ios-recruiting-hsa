//
//  GenreApiResponse.swift
//  ios-recruiting-hsa
//
//  Created by Hans Fehrmann on 5/30/19.
//  Copyright © 2019 Hans Fehrmann. All rights reserved.
//

import Foundation

struct GenreApiResponse: Codable {

    enum CodingKeys: String, CodingKey {
        case genres
    }

    let genres: [Genre]
}
