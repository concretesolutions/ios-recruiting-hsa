//
//  MovieModel.swift
//  movs
//
//  Created by Andrés Alexis Rivas Solorzano on 10/3/19.
//  Copyright © 2019 Andrés Alexis Rivas Solorzano. All rights reserved.
//

import Foundation

class MovieModel:  Codable, ImagePathURL {
    
    var id: Int
    var title: String
    var originalTitle: String
    var originalLanguage: String
    var poster: String?
    var overview: String
    var releaseDate: String
    var popularity: Double
    var backdropPath: String?
    var voteCount: Int
    var voteAverage: Double
    var video: Bool
    var adult: Bool
    var genreIds: [Int]
    var isFavorite: Bool? = false
    
    enum CodingKeys: String, CodingKey{
        case id
        case title
        case originalTitle = "original_title"
        case originalLanguage = "original_language"
        case poster = "poster_path"
        case overview
        case releaseDate = "release_date"
        case popularity
        case backdropPath = "backdrop_path"
        case voteCount = "vote_count"
        case voteAverage = "vote_average"
        case video
        case adult
        case genreIds = "genre_ids"
    }
    
    func getPosterImageURL(withSize: SupportedImageSizes = .original)->URL?{
        return self.getImageURL(forPath: poster, imageSize: withSize)
    }
    
    func getBackDropImageURL(withSize: SupportedImageSizes = .original)->URL?{
        return self.getImageURL(forPath: backdropPath, imageSize: withSize)
    }
   
}
