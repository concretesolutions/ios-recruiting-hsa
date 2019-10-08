//
//  DataBaseManager.swift
//  MovieScope
//
//  Created by Andrés Alexis Rivas Solorzano on 7/11/19.
//  Copyright © 2019 Andrés Alexis Rivas Solorzano. All rights reserved.
//

import Foundation
import CoreData
import UIKit


class DataBaseManager{
    
    static let shared = DataBaseManager()
    let coreStack: NSPersistentContainer
    
    init() {
       
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            fatalError("No se ha podido cargar el appdelegate")
        }
        
        coreStack = appDelegate.persistentContainer
    }
    
    func deletePreviusResults<T:NSManagedObject>(objectToConserve: T, search: NSPredicate? = nil){
        let context = coreStack.viewContext
        
        let results = queryCoreData(T.self, search: search)
        for record in results{
            if record != objectToConserve{
                context.delete(record)
            }
        }
        
        do{
            try context.save()
        }catch{
            #if DEBUG
                fatalError("COREDATA SAVE TRY FAILED \(error.localizedDescription)")
            #endif
        }
    }
    
    
    
    func deleteResultsInQuery<T: NSManagedObject>(_ type : T.Type, search: NSPredicate? = nil){
        
        let context = coreStack.viewContext
        
        let results = queryCoreData(T.self, search: search)
        for record in results{
            context.delete(record)
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

