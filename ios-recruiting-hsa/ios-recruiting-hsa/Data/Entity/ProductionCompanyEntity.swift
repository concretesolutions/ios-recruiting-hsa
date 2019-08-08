//
//  ProductionCompanyEntity.swift
//  ios-recruiting-hsa
//
//  Created on 08-08-19.
//

struct ProductionCompanyEntity: Codable {
    let id: Int
    let logoPath: String?
    let name: String
    let originCountry: String
    
    private enum CodingKeys: String, CodingKey {
        case id
        case logoPath = "logo_path"
        case name
        case originCountry = "origin_country"
    }
}
