//
//  MovFavTmdb.swift
//  tmdb-app
//
//  Created by training on 04-07-22.
//

import CoreData

@objc(MovFavTmdb)
class MovFavTmdb: NSManagedObject {
    
    @NSManaged var id: String!
    @NSManaged var title: String!
    
}
