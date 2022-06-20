//
//  FavoriteManage.swift
//  MoviesApp
//
//  Created by gustavo.salazar on 20/06/22.
//

import Foundation
import UIKit
import CoreData

//MARK: -
class FavoriteManager{
    
    static func setFavorite( movies: inout [Movie]){
        
        let moviesDB = getFavoriteMovie()
        
        for (index,_) in movies.enumerated(){
            movies[index].favorite =  moviesDB.first {$0.idMovieDB as! Int == movies[index].id } != nil ? true: false
        }
    }
    
    static func getFavoriteMovie( ) -> [MovieDB]{
        
    var moviesResult: [MovieDB] = []
    
    let context = getContext()
    let request = NSFetchRequest<NSFetchRequestResult>(entityName: "MovieDB")
    
    
    do{
        let results:NSArray = try context.fetch(request) as NSArray
        for result in results {
            let movieDB = result as! MovieDB
            moviesResult.append(movieDB)
            print(movieDB)
        }
         
        return moviesResult
    }catch{
        print(error)
        return []
    }
        
      
    }
    
    
    static  func getContext() -> NSManagedObjectContext {
        let appDelegate: AppDelegate
        if Thread.current.isMainThread {
            appDelegate = UIApplication.shared.delegate as! AppDelegate
        } else {
            appDelegate = DispatchQueue.main.sync {
                return UIApplication.shared.delegate as! AppDelegate
            }
        }
        return appDelegate.persistentContainer.viewContext
    }
}
