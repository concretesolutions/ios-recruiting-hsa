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

//MARK: -
class FavoritesPresenter{
    weak var delegate: PresenterFavoriteDelegate?
    
    public func setViewDelegate(delegate: PresenterFavoriteDelegate){
        self.delegate = delegate
    }
   
    func getFavorites(releaseYear:Int=0,gender:String=""){
        
        let context = getContext()
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "MovieDB")
        
        var moviesResult: [MovieDB] = []
        
        do{
            let results:NSArray = try context.fetch(request) as NSArray
            for result in results {
                let movieDB = result as! MovieDB
                moviesResult.append(movieDB)
                print(movieDB)
                
            }
            
            if releaseYear != 0 || gender != "" {
                if releaseYear != 0 {
                    moviesResult = moviesResult.filter{$0.releaseYear == releaseYear}
                }
                if gender != ""{
                    moviesResult = moviesResult.filter{ item in
                        if item.genre != nil {
                        return item.genre.contains(gender)
                    }
                    return false
                    }
                }
            }
            
            self.delegate?.presentMoviesFavorites(movies:moviesResult)
            
        }catch{
            print(error)
        }
    }
    
    
    private  func getContext() -> NSManagedObjectContext {
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
    
    func deleteFavorite(){
        
    }
}
