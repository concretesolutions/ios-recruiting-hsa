//
//  MovieModel.swift
//  MovieScope
//
//  Created by Andrés Alexis Rivas Solorzano on 7/2/19.
//  Copyright © 2019 Andrés Alexis Rivas Solorzano. All rights reserved.
//

import Foundation
import CoreData

class MovieModel: NSManagedObject, Codable, NSCoding, ImagePathURL {
    
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
    
    
    //MOTHER OF BOILERPLATE
    func encode(with aCoder: NSCoder) {
        aCoder.encode(id, forKey: CodingKeys.id.rawValue)
        aCoder.encode(title, forKey: CodingKeys.title.rawValue)
        aCoder.encode(originalTitle, forKey: CodingKeys.originalTitle.rawValue)
        aCoder.encode(originalLanguage, forKey: CodingKeys.originalLanguage.rawValue)
        aCoder.encode(poster, forKey: CodingKeys.poster.rawValue)
        aCoder.encode(overview, forKey: CodingKeys.overview.rawValue)
        aCoder.encode(releaseDate, forKey: CodingKeys.releaseDate.rawValue)
        aCoder.encode(popularity, forKey: CodingKeys.popularity.rawValue)
        aCoder.encode(backdropPath, forKey: CodingKeys.backdropPath.rawValue)
        aCoder.encode(voteCount, forKey: CodingKeys.voteCount.rawValue)
        aCoder.encode(voteAverage, forKey: CodingKeys.voteAverage.rawValue)
        aCoder.encode(adult, forKey: CodingKeys.adult.rawValue)
        aCoder.encode(video, forKey: CodingKeys.video.rawValue)
        aCoder.encode(genreIds, forKey: CodingKeys.genreIds.rawValue)
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        
        let managedObjectContext = DataBaseManager.shared.coreStack.viewContext
        
        guard let entity = NSEntityDescription.entity(forEntityName: "MovieModel", in: managedObjectContext) else { fatalError("Cannot retrieve entity") }
        
        
        self.init(entity: entity, insertInto: nil)
       
        self.id = Int(aDecoder.decodeInt64(forKey: CodingKeys.id.rawValue))
        
        guard let title = aDecoder.decodeObject(forKey: CodingKeys.title.rawValue) as? String else { return }
        self.title = title
        
        guard let originalTitle = aDecoder.decodeObject(forKey: CodingKeys.originalTitle.rawValue) as? String else { return }
        self.originalTitle = originalTitle
        
        guard let originalLanguage = aDecoder.decodeObject(forKey: CodingKeys.originalLanguage.rawValue) as? String  else { return }
        self.originalLanguage = originalLanguage
        
        self.poster = aDecoder.decodeObject(forKey: CodingKeys.poster.rawValue) as? String
        
        guard let overView = aDecoder.decodeObject(forKey: CodingKeys.overview.rawValue) as? String else { return }
        self.overview = overView
        
        guard let releasedate = aDecoder.decodeObject(forKey: CodingKeys.releaseDate.rawValue) as? String else { return }
        self.releaseDate = releasedate
        
        self.popularity = aDecoder.decodeDouble(forKey: CodingKeys.popularity.rawValue)
        
     
        self.backdropPath = aDecoder.decodeObject(forKey: CodingKeys.backdropPath.rawValue) as? String
        
        self.voteCount = Int(aDecoder.decodeInt64(forKey: CodingKeys.voteCount.rawValue))
        
        self.voteAverage = aDecoder.decodeDouble(forKey: CodingKeys.voteAverage.rawValue)
        
        self.video = aDecoder.decodeBool(forKey: CodingKeys.video.rawValue)
        
        self.adult = aDecoder.decodeBool(forKey: CodingKeys.adult.rawValue)
        
        guard let genres = aDecoder.decodeObject(forKey: CodingKeys.genreIds.rawValue) as? [Int] else { return }
        self.genreIds = genres
        
    }
    
    override init(entity: NSEntityDescription, insertInto context: NSManagedObjectContext?) {
        super.init(entity: entity, insertInto: context)
    }
    
    
    //BOILERPLATE
    // MARK: - Decodable
    required convenience init(from decoder: Decoder) throws {

        guard let contextUserInfoKey = CodingUserInfoKey.managedObjectContext else { fatalError("cannot find context key") }

        guard let managedObjectContext = decoder.userInfo[contextUserInfoKey] as? NSManagedObjectContext else { fatalError("cannot Retrieve context") }

        guard let entity = NSEntityDescription.entity(forEntityName: "MovieModel", in: managedObjectContext) else { fatalError("Cannot retrieve entity") }


        self.init(entity: entity, insertInto: managedObjectContext)

        let container = try decoder.container(keyedBy: CodingKeys.self)

        guard let id = try container.decodeIfPresent(Int.self, forKey: .id) else { return }
        self.id = id

        guard let title = try container.decodeIfPresent(String.self, forKey: .title) else { return }
        self.title = title

        guard let originalTitle = try container.decodeIfPresent(String.self, forKey: .originalTitle) else { return }
        self.originalTitle = originalTitle

        guard let originalLanguage = try container.decodeIfPresent(String.self, forKey: .originalLanguage) else { return }
        self.originalLanguage = originalLanguage

        self.poster = try container.decodeIfPresent(String.self, forKey: .poster)

        guard let overView = try container.decodeIfPresent(String.self, forKey: .overview) else { return }
        self.overview = overView

        guard let releasedate = try container.decodeIfPresent(String.self, forKey: .releaseDate) else { return }
        self.releaseDate = releasedate

        guard let popularity = try container.decodeIfPresent(Double.self, forKey: .popularity) else { return }
        self.popularity = popularity

        self.backdropPath = try container.decodeIfPresent(String.self, forKey: .backdropPath)

        guard let voteCount = try container.decodeIfPresent(Int.self, forKey: .voteCount) else { return }
        self.voteCount = voteCount

        guard let voteAvg = try container.decodeIfPresent(Double.self, forKey: .voteAverage) else { return }
        self.voteAverage = voteAvg

        guard let video = try container.decodeIfPresent(Bool.self, forKey: .video) else { return }
        self.video = video

        guard let adult = try container.decodeIfPresent(Bool.self, forKey: .adult) else { return }
        self.adult = adult

        guard let genres = try container.decodeIfPresent([Int].self, forKey: .genreIds) else { return }
        self.genreIds = genres

    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(title, forKey: .title)
        try container.encode(originalTitle, forKey: .originalTitle)
        try container.encode(originalLanguage, forKey: .originalLanguage)
        try container.encode(poster, forKey: .poster)
        try container.encode(overview, forKey: .overview)
        try container.encode(releaseDate, forKey: .releaseDate)
        try container.encode(popularity, forKey: .popularity)
        try container.encode(backdropPath, forKey: .backdropPath)
        try container.encode(voteCount, forKey: .voteCount)
        try container.encode(voteAverage, forKey: .voteAverage)
        try container.encode(video, forKey: .video)
        try container.encode(adult, forKey: .adult)
        try container.encode(genreIds, forKey: .genreIds)

    }
    
    func getPosterImageURL(withSize: SupportedImageSizes = .original)->URL?{
        return self.getImageURL(forPath: poster, imageSize: withSize)
    }
    
    func getBackDropImageURL(withSize: SupportedImageSizes = .original)->URL?{
        return self.getImageURL(forPath: backdropPath, imageSize: withSize)
    }
    
    func getApprovalRating()->Float{
        return Float(voteAverage) / 10.0
    }
    
}
