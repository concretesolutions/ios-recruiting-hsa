//
//  SpokenLanguageEntity.swift
//  ios-recruiting-hsa
//
//  Created on 08-08-19.
//

struct SpokenLanguageEntity: Codable {
    let iso6391: String
    let name: String
    
    private enum CodingKeys: String, CodingKey {
        case iso6391 = "iso_639_1"
        case name
    }
}
