//
//  ProductionCompanyEntity.swift
//  Concrete-Movies
//
//  Created by Audel Dugarte on 4/28/19.
//  Copyright © 2019 Audel Dugarte. All rights reserved.
//

struct ProductionCompanyEntity: Codable {
    let id: Int
    let logoPath: String?
    let name: String
    let originCountry: String
    
    private enum CodingKeys: String, CodingKey{
        case id
        case logoPath = "logo_path"
        case name
        case originCountry = "origin_country"
    }
}
