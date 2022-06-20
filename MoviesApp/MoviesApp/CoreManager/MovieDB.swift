//
//  MovieDB.swift
//  MoviesApp
//
//  Created by gustavo.salazar on 19/06/22.
//

import Foundation
import CoreData

@objc(MovieDB)
class MovieDB:NSManagedObject{
    @NSManaged var id: NSNumber!
    @NSManaged var idMovieDB: NSNumber!
    @NSManaged var poster: String!
    @NSManaged var title: String!
    @NSManaged var releaseYear: Int32
    @NSManaged var sinopsis: String!
}

