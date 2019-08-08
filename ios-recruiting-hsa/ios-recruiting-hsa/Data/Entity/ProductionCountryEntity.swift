//
//  ProductionCountryEntity.swift
//  ios-recruiting-hsa
//
//  Created on 08-08-19.
//

struct ProductionCountryEntity: Codable {
    let iso31661: String
    let name: String
    
    private enum CodingKeys: String, CodingKey {
        case iso31661 = "iso_3166_1"
        case name
    }
}
