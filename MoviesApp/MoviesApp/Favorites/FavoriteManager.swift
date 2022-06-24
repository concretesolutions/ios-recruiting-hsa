//
//  FavoriteManage.swift
//  MoviesApp
//
//  Created by gustavo.salazar on 20/06/22.
//

import Foundation
import UIKit
import CoreData

// MARK: - Get favorites save in deveice
class FavoriteManager {
    static func setFavorite( movies: inout [Movie]) {
        let moviesDB = getFavoriteMovie()

        for (index) in movies.indices {
            movies[index].favorite =  moviesDB.first {
                if let idDB =  $0.idMovieDB as? Int {
                    return idDB == movies[index].id
                }
              return false
            } != nil ? true: false
        }
    }

    static func getFavoriteMovie( ) -> [MovieDB] {

    var moviesResult: [MovieDB] = []

    let context = getContext()
    let request = NSFetchRequest<NSFetchRequestResult>(entityName: "MovieDB")

    do {
        let results: NSArray = try context.fetch(request) as NSArray
        for result in results {
            if let movieDB = result as? MovieDB {
            moviesResult.append(movieDB)
                print(movieDB)
            }
        }

        return moviesResult
    } catch {
        print(error)
        return []
    }
}
    static  func getContext() -> NSManagedObjectContext {
        var appDelegate: AppDelegate = AppDelegate()
        if Thread.current.isMainThread {
            if let app = UIApplication.shared.delegate as? AppDelegate {
                appDelegate = app
            }
        } else {
            appDelegate = DispatchQueue.main.sync {
                return (UIApplication.shared.delegate as? AppDelegate)!
            }
        }
        return appDelegate.persistentContainer.viewContext
    }
}
