//
//  CoreDataProvider.swift
//  movs
//
//  Created by Andrés Alexis Rivas Solorzano on 10/6/19.
//  Copyright © 2019 Andrés Alexis Rivas Solorzano. All rights reserved.
//

import Foundation
import CoreData
import UIKit

class CoreDataProvider{
    
    static let shared = CoreDataProvider()
    let coreStack: NSPersistentContainer
    
    init() {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            fatalError("No se ha podido cargar el appdelegate")
        }
        coreStack = appDelegate.persistentContainer
    }
    
    func deleteResultsInQuery<T: NSManagedObject>(_ type : T.Type, search: NSPredicate? = nil){
        
        let context = coreStack.viewContext
        
        let results = queryCoreData(T.self, search: search)
        for record in results{
            context.delete(record)
        }
    }
    
    func recordExist<T: NSManagedObject>(_ T: T.Type, search: NSPredicate?)->Bool{
        let context = coreStack.viewContext
        let entityName = T.description()
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: entityName)
        fetchRequest.fetchLimit =  1
        fetchRequest.predicate = search
        do {
            let count = try context.count(for: fetchRequest)
            if count > 0 {
                return true
            }else {
                return false
            }
        }catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
            return false
        }
    }
    
    func addRecord<T: NSManagedObject>(_ type : T.Type) -> T? {
        let entityName = T.description()
        let context = coreStack.viewContext
        guard let newEntity = NSEntityDescription.entity(forEntityName: entityName, in: context) else { return nil }
        let newRecord = T(entity: newEntity, insertInto: context)
        return newRecord
    }
    
    func save(){
        do{
            try coreStack.viewContext.save()
        }catch{
            print("Error saving")
        }
    }
    
    func queryCoreData<T: NSManagedObject>(_ type : T.Type, search: NSPredicate?, sort: NSSortDescriptor? = nil, multiSort: [NSSortDescriptor]? = nil) -> [T] {
        
        let context = coreStack.viewContext
        let request = T.fetchRequest()
        
        if let predicate = search{
            request.predicate = predicate
        }
        
        if let sortDescriptors = multiSort{
            request.sortDescriptors = sortDescriptors
        }
            
        else if let sortDescriptor = sort{
            request.sortDescriptors = [sortDescriptor]
        }
        
        do{
            let results = try context.fetch(request)
            return results as! [T]
        }catch{
            
            print("Error with request: \(error)")
            return []
        }
        
    }
    
}

