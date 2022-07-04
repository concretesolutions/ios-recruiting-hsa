//
//  SearchResponse.swift
//  ios-recruiting-hsa
//
//  Created by training on 04-07-22.
//

import Foundation
class SearchResponse: Codable {
    let page: Int
    let results: [DatosSearchResponse]
    let total_pages, total_results: Int

}


class DatosSearchResponse: Codable{
    
    var adult: Bool?
    var backdropPath : String?
    var genreIDS: [Int]
    var id : Int?
    var originalLanguage : String?
    var originalTitle : String?
    var overview : String?
    var popularity : Double?
    var posterPath : String?
    var releaseDate : String?
    var title : String?
    var video : Bool?
    var voteAverage : Double?
    var voteCount : Int?
    
    
    enum CodingKeys: String, CodingKey {
        case voteCount = "vote_count"
        case id, video
        case voteAverage = "vote_average"
        case title, popularity
        case posterPath = "poster_path"
        case originalLanguage = "original_language"
        case originalTitle = "original_title"
        case genreIDS = "genre_ids"
        case backdropPath = "backdrop_path"
        case adult, overview
        case releaseDate = "release_date"
    }
}
