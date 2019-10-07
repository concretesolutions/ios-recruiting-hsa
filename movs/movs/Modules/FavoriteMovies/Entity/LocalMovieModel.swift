//
//  LocalMovieModel.swift
//  movs
//
//  Created by Andrés Alexis Rivas Solorzano on 10/6/19.
//  Copyright © 2019 Andrés Alexis Rivas Solorzano. All rights reserved.
//

import Foundation
import CoreData

@objc(LocalMovieModel)
class LocalMovieModel: NSManagedObject, ImagePathURL{
    
    @NSManaged var id: Int
    @NSManaged var title: String
    @NSManaged var originalTitle: String
    @NSManaged var originalLanguage: String
    @NSManaged var poster: String?
    @NSManaged var overview: String
    @NSManaged var releaseDate: String
    @NSManaged var popularity: Double
    @NSManaged var backdropPath: String?
    @NSManaged var voteCount: Int
    @NSManaged var voteAverage: Double
    @NSManaged var video: Bool
    @NSManaged var adult: Bool
    @NSManaged var genreIds: [Int]
    
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
    
    func saveMovie(movie: MovieModel){
        self.id = movie.id
        self.title = movie.title
        self.originalTitle = movie.originalTitle
        self.originalLanguage = movie.originalLanguage
        self.poster = movie.poster
        self.overview = movie.overview
        self.releaseDate = movie.releaseDate
        self.popularity = movie.popularity
        self.backdropPath = movie.backdropPath
        self.voteCount = movie.voteCount
        self.voteAverage = movie.voteAverage
        self.video = movie.video
        self.adult = movie.adult
        self.genreIds = movie.genreIds
    }
    
    func getPosterImageURL(withSize: SupportedImageSizes = .original)->URL?{
        return self.getImageURL(forPath: poster, imageSize: withSize)
    }
    
    func getBackDropImageURL(withSize: SupportedImageSizes = .original)->URL?{
        return self.getImageURL(forPath: backdropPath, imageSize: withSize)
    }
    
}

