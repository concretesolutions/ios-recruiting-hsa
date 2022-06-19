//
//  FavoriresPresenter.swift
//  MoviesApp
//
//  Created by gustavo.salazar on 19/06/22.
//

import Foundation
import UIKit
import CoreData

protocol FavoritesPresenterDelegate: AnyObject{
    func presentMoviesFavorites(movies:[MovieDB])
    
}

typealias PresenterFavoriteDelegate = FavoritesPresenterDelegate & UIViewController


class FavoritesPresenter{
    weak var delegate: PresenterFavoriteDelegate?
    
    public func setViewDelegate(delegate: PresenterFavoriteDelegate){
        self.delegate = delegate
    }
    
    func getFavorites(){
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context: NSManagedObjectContext = appDelegate.persistentContainer.viewContext
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "MovieDB")
        
        var moviesResult: [MovieDB] = []
        do{
            let results:NSArray = try context.fetch(request) as NSArray
            for result in results {
                let movieDB = result as! MovieDB
                moviesResult.append(movieDB)
                print(movieDB)
                
            }
            self.delegate?.presentMoviesFavorites(movies:moviesResult)
        }catch{
            print(error)
        }
    }
}
