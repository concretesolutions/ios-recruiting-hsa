//
//  ProductionCountryEntity.swift
//  ios-recruiting-hsa
//
//  Created by Freddy Miguel Vega Zárate on 08-08-19.
//  Copyright © 2019 Freddy Miguel Vega Zárate. All rights reserved.
//

struct ProductionCountryEntity: Codable {
    let iso31661: String
    let name: String
    
    private enum CodingKeys: String, CodingKey {
        case iso31661 = "iso_3166_1"
        case name
    }
}
