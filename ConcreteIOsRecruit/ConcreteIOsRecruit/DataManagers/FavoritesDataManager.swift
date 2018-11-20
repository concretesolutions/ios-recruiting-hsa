//
//  FavoritesDataManager.swift
//  ConcreteIOsRecruit
//
//  Created by Matías Contreras on 11/19/18.
//  Copyright © 2018 Matias Contreras. All rights reserved.
//

import Foundation

struct FavoritesDataManger{
    var favorites : Favorites
    
    enum ActionPerformed{
        case added
        case removed
    }
    
    init() {
        debugPrint("entro al init del FavoritesDataManger")
        if let favorites = DataManager().retrieve(decodingType: Favorites.self, storingKey: Favorites().key){
            self.favorites = favorites
        }
        else{
            favorites = Favorites()
        }
    }
    
    func isAlreadyInFavorites(movie: Movie) -> Bool{
        debugPrint("entro")
        if favorites.movies.index(of: movie) != nil{
            return true
        }
        return false
    }
    
    mutating func addRemoveMovie(movie: Movie) -> ActionPerformed{
        if let index = favorites.movies.index(of: movie){
            favorites.movies.remove(at: index)
            debugPrint("Removed movie from favorites")
            DataManager().save(object: favorites)
            return .removed
        }
        else{
            favorites.movies.append(movie)
            DataManager().save(object: favorites)
            debugPrint("Added movie to favorites")
            return .added
            
        }
    }
}
