//
//  MovieDetailModel.swift
//  movs
//
//  Created by Andrés Alexis Rivas Solorzano on 10/6/19.
//  Copyright © 2019 Andrés Alexis Rivas Solorzano. All rights reserved.
//

import Foundation

class MovieDetailModel: Codable, ImagePathURL{
    
    var id: Int
    var adult: Bool
    var backdropPath: String?
    var posterPath: String?
    var genreList: [MovieGenreModel]
    var overview: String
    var status: String
    var budget: Int
    var runtime: Int
    var revenue: Int
    var releaseDate: String
    var title: String
    var video: Bool
    var originalTitle: String
    var voteAverage: Double
    
    enum CodingKeys: String, CodingKey{
        case id
        case adult
        case backdropPath = "backdrop_path"
        case posterPath = "poster_path"
        case genreList = "genres"
        case overview
        case status
        case budget
        case runtime
        case revenue
        case releaseDate = "release_date"
        case title
        case video
        case originalTitle = "original_title"
        case voteAverage = "vote_average"
    }
    
    func getPosterPathImageURL(withSize: SupportedImageSizes = .original)->URL?{
        return getImageURL(forPath: posterPath, imageSize: withSize)
    }
    
    func getBackDropImageURL(withSize: SupportedImageSizes = .original)->URL?{
        return getImageURL(forPath: backdropPath, imageSize: withSize)
    }
}
