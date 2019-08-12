//
//  MovieLocalDataimpl.swift
//  ios-recruiting-hsa
//
//  Created on 8/12/19.
//

import UIKit
import CoreData

class MovieLocalDataimpl: MovieLocalData {
    func save(movie: FavoriteMovieEntity, completionHandler: @escaping (ErrorEntity?) -> Void) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        
        let managedContext = appDelegate.persistentContainer.viewContext
        let entity = NSEntityDescription.entity(forEntityName: Constants.LocalData.Entity.name, in: managedContext)!
        let favorite = NSManagedObject(entity: entity, insertInto: managedContext)
        
        favorite.setValue(movie.genres,
                          forKeyPath: Constants.LocalData.Entity.Fields.genres
        )
        favorite.setValue(movie.id,
                          forKeyPath: Constants.LocalData.Entity.Fields.id
        )
        favorite.setValue(movie.overview,
                          forKeyPath: Constants.LocalData.Entity.Fields.overview
        )
        favorite.setValue(movie.posterPath,
                          forKeyPath: Constants.LocalData.Entity.Fields.posterPath
        )
        favorite.setValue(movie.year,
                          forKeyPath: Constants.LocalData.Entity.Fields.releaseDate
        )
        favorite.setValue(movie.title,
                          forKeyPath: Constants.LocalData.Entity.Fields.title
        )
        
        do {
            try managedContext.save()
            completionHandler(nil)
        } catch {
            completionHandler(ErrorEntity(statusMessage: Constants.ErrorMessages.saveError,
                                          statusCode: 0)
            )
        }
    }

    func fetch(completionHandler: @escaping ([FavoriteMovieEntity]?, ErrorEntity?) -> Void) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        
        let managedContext = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: Constants.LocalData.Entity.name)
        
        do {
            var favorites = [FavoriteMovieEntity]()
            let objects = try managedContext.fetch(fetchRequest)
            favorites = objects.map {
                FavoriteMovieEntity(id: $0.value(forKey: Constants.LocalData.Entity.Fields.id) as! Int,
                                    title: $0.value(forKey: Constants.LocalData.Entity.Fields.title) as! String,
                                    overview: $0.value(forKey: Constants.LocalData.Entity.Fields.overview) as! String,
                                    posterPath: $0.value(forKey: Constants.LocalData.Entity.Fields.posterPath) as? String,
                                    genres: $0.value(forKey: Constants.LocalData.Entity.Fields.genres) as! [String],
                                    year: $0.value(forKey: Constants.LocalData.Entity.Fields.releaseDate) as! String
                )
            }
            completionHandler(favorites, nil)
        } catch {
            completionHandler(nil,
                              ErrorEntity(statusMessage: Constants.ErrorMessages.fetchError,
                                          statusCode: 0)
            )
        }
    }
    
    func fetch(movieId: Int, completionHandler: @escaping (FavoriteMovieEntity?, ErrorEntity?) -> Void) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        
        let managedContext = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: Constants.LocalData.Entity.name)
        fetchRequest.predicate = NSPredicate(format: "\(Constants.LocalData.Entity.Fields.id) = %d", movieId)
        
        do {
            let objects = try managedContext.fetch(fetchRequest)
            if objects.count > 0 {
                let movie = FavoriteMovieEntity(id: objects[0].value(forKey: Constants.LocalData.Entity.Fields.id) as! Int,
                                                title: objects[0].value(forKey: Constants.LocalData.Entity.Fields.title) as! String,
                                                overview: objects[0].value(forKey: Constants.LocalData.Entity.Fields.overview) as! String,
                                                posterPath: objects[0].value(forKey: Constants.LocalData.Entity.Fields.posterPath) as? String,
                                                genres: objects[0].value(forKey: Constants.LocalData.Entity.Fields.genres) as! [String],
                                                year: objects[0].value(forKey: Constants.LocalData.Entity.Fields.releaseDate) as! String)
                completionHandler(movie, nil)
            } else {
                completionHandler(nil, nil)
            }
        } catch {
            completionHandler(nil, ErrorEntity(statusMessage: Constants.ErrorMessages.deleteError,
                                          statusCode: 0)
            )
        }
    }
    
    func delete(movie: FavoriteMovieEntity, completionHandler: @escaping (ErrorEntity?) -> Void) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        
        let managedContext = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: Constants.LocalData.Entity.name)
        fetchRequest.predicate = NSPredicate(format: "\(Constants.LocalData.Entity.Fields.id) = %d", movie.id)
        
        do {
            let objects = try managedContext.fetch(fetchRequest)
            managedContext.delete(objects[0])
            try managedContext.save()
            completionHandler(nil)
        } catch {
            completionHandler(ErrorEntity(statusMessage: Constants.ErrorMessages.deleteError,
                                          statusCode: 0)
            )
        }
    }
}
