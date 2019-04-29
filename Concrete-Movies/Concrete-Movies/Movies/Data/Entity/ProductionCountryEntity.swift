//
//  ProductionCountryEntity.swift
//  Concrete-Movies
//
//  Created by Audel Dugarte on 4/28/19.
//  Copyright © 2019 Audel Dugarte. All rights reserved.
//

struct ProductionCountryEntity: Codable {
    let isoId: String
    let name: String
    
    private enum CodingKeys: String, CodingKey {
        case isoId = "iso_3166_1"
        case name
    }
}
