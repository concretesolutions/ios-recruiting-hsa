//
//  PersistenceController.swift
//  Movies
//
//  Created by Pedro on 23-07-24.
//

import Foundation

import CoreData

class PersistenceController {
    static let shared = PersistenceController()

    let container: NSPersistentContainer
    var context: NSManagedObjectContext {
        return container.viewContext
    }

    init() {
        container = NSPersistentContainer(name: "Movies")
        container.loadPersistentStores { _, error in
            if let error = error {
                print("Error while loading persistence storage \(error)")
            }
        }
        container.viewContext.automaticallyMergesChangesFromParent = true
    }
}
