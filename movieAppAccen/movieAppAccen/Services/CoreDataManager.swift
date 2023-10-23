//
//  CoreDataManager.swift
//  movieAppAccen
//
//  Created by Orlando Velasco on 22-10-23.
//
// CoreDataManager.swift

import Foundation
import CoreData

class CoreDataManager {
    
    static let shared = CoreDataManager()
    
    let container: NSPersistentContainer
    
    private init() {
        container = NSPersistentContainer(name: "MovieDataModel")
        container.loadPersistentStores { (description, error) in
            if let error = error {
                fatalError("Error: \(error.localizedDescription)")
            }
        }
    }
    
    func saveContext() {
        do {
            try container.viewContext.save()
        } catch {
            print("Error: \(error.localizedDescription)")
        }
    }
}
