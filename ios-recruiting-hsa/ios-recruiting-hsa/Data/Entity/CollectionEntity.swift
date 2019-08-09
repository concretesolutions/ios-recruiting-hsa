//
//  CollectionEntity.swift
//  ios-recruiting-hsa
//
//  Created on 8/8/19.
//

struct CollectionEntity: Codable {
    let id: Int
    let name: String
    let overview: String?
    let posterPath: String?
    let backdropPath: String
    let parts: [PartEntity]?
    
    private enum CodingKeys: String, CodingKey {
        case id
        case name
        case overview
        case posterPath = "poster_path"
        case backdropPath = "backdrop_path"
        case parts
    }
}
