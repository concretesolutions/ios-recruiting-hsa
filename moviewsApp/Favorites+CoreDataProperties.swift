//
//  Favorites+CoreDataProperties.swift
//  
//
//  Created by carlos jaramillo on 9/3/18.
//
//

import Foundation
import CoreData


extension Favorites {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Favorites> {
        return NSFetchRequest<Favorites>(entityName: "Favorites")
    }

    @NSManaged public var backdropPath: String?
    @NSManaged public var genreIds: NSArray?
    @NSManaged public var id: Int64
    @NSManaged public var isAdults: Bool
    @NSManaged public var originalLanguage: String?
    @NSManaged public var overview: String?
    @NSManaged public var popularity: Double
    @NSManaged public var posterPath: String?
    @NSManaged public var releaseDate: String?
    @NSManaged public var title: String?
    @NSManaged public var video: Bool
    @NSManaged public var voteAverage: Double
    @NSManaged public var voteCount: Int64

}
