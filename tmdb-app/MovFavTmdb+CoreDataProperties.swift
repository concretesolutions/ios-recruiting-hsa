//
//  MovFavTmdb+CoreDataProperties.swift
//  tmdb-app
//
//  Created by training on 04-07-22.
//
//

import Foundation
import CoreData


extension MovFavTmdb {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<MovFavTmdb> {
        return NSFetchRequest<MovFavTmdb>(entityName: "MovFavTmdb")
    }

    @NSManaged public var id: String?
    @NSManaged public var title: String?

}

extension MovFavTmdb : Identifiable {

}
