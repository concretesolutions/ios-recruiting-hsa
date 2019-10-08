//
//  MovieDetailModel.swift
//  MovieScope
//
//  Created by Andrés Alexis Rivas Solorzano on 7/5/19.
//  Copyright © 2019 Andrés Alexis Rivas Solorzano. All rights reserved.
//

import Foundation
import CoreData

// Nota: el atributo `runtime` esta definido por la api de moviedb como un valor opcional, sin embargo los ints opcionales no son facilmente soportados por coredata es por eso que en caso de llegar null en la respuesta del servicio se le asigna un valor de 0 por defecto.

class MovieDetailModel: NSManagedObject, Codable, ImagePathURL{
    
    @NSManaged var id: Int
    @NSManaged var adult: Bool
    @NSManaged var backdropPath: String?
    @NSManaged var posterPath: String?
    @NSManaged var genreList: [MovieGenreModel]
    @NSManaged var overview: String
    @NSManaged var status: String
    @NSManaged var budget: Int
    @NSManaged var runtime: Int
    @NSManaged var revenue: Int
    @NSManaged var releaseDate: String
    @NSManaged var title: String
    @NSManaged var video: Bool
    @NSManaged var originalTitle: String
    @NSManaged var voteAverage: Double
    
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
    
    //BOILERPLATE
    // MARK: - Decodable
    
    required public convenience init(from decoder: Decoder) throws {
        
        guard let contextUserInfoKey = CodingUserInfoKey.managedObjectContext else { fatalError("cannot find context key") }
        
        guard let managedObjectContext = decoder.userInfo[contextUserInfoKey] as? NSManagedObjectContext else { fatalError("cannot Retrieve context") }
        
        guard let entity = NSEntityDescription.entity(forEntityName: "MovieDetailModel", in: managedObjectContext) else { fatalError("Cannot retrieve entity") }
        
        
        self.init(entity: entity, insertInto: managedObjectContext)
        
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        guard let id = try container.decodeIfPresent(Int.self, forKey: .id) else { return }
        self.id = id
        
        guard let adult = try container.decodeIfPresent(Bool.self, forKey: .adult) else { return }
        self.adult = adult
        
        guard let title = try container.decodeIfPresent(String.self, forKey: .title) else { return }
        self.title = title
        
        self.backdropPath = try container.decodeIfPresent(String.self, forKey: .backdropPath)
        self.posterPath = try container.decodeIfPresent(String.self, forKey: .posterPath)
        
        guard let genres = try container.decodeIfPresent([MovieGenreModel].self, forKey: .genreList) else { return }
        self.genreList = genres
        
        guard let overView = try container.decodeIfPresent(String.self, forKey: .overview) else { return }
        self.overview = overView
        
        guard let status = try container.decodeIfPresent(String.self, forKey: .status) else { return }
        self.status = status
        
        guard let budget = try container.decodeIfPresent(Int.self, forKey: .budget) else { return }
        self.budget = budget
        
        self.runtime = try container.decodeIfPresent(Int.self, forKey: .runtime) ?? 0
        
        guard let revenue = try container.decodeIfPresent(Int.self, forKey: .revenue) else { return }
        self.revenue = revenue
        
        guard let releasedate = try container.decodeIfPresent(String.self, forKey: .releaseDate) else { return }
        self.releaseDate = releasedate
        
        guard let video = try container.decodeIfPresent(Bool.self, forKey: .video) else { return }
        self.video = video
        
        guard let originalTitle = try container.decodeIfPresent(String.self, forKey: .originalTitle) else { return }
        self.originalTitle = originalTitle
        
        guard let voteAverage = try container.decodeIfPresent(Double.self, forKey: .voteAverage) else { return }
        self.voteAverage = voteAverage
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(title, forKey: .title)
        try container.encode(originalTitle, forKey: .originalTitle)
        try container.encode(posterPath, forKey: .posterPath)
        try container.encode(overview, forKey: .overview)
        try container.encode(releaseDate, forKey: .releaseDate)
        try container.encode(backdropPath, forKey: .backdropPath)
        try container.encode(video, forKey: .video)
        try container.encode(adult, forKey: .adult)
        try container.encode(genreList, forKey: .genreList)
        try container.encode(revenue, forKey: .revenue)
        try container.encode(budget, forKey: .budget)
        try container.encode(runtime, forKey: .runtime)
        try container.encode(status, forKey: .status)
        try container.encode(voteAverage, forKey: .voteAverage)
    }
    
    func getPosterPathImageURL(withSize: SupportedImageSizes = .original)->URL?{
        return getImageURL(forPath: posterPath, imageSize: withSize)
    }
    
    func getApprovalRating()->Float{
        return Float(voteAverage) / 10.0
    }
    
}


