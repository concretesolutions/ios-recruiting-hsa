//
//  FavouriteManager.swift
//  movie-app-hsa
//
//  Created by training on 03-07-22.
//

import Foundation

class FavouriteManager: FavouriteManagerProtocol {
    
    static let shared = FavouriteManager()
    
    // MARK: Properties
    var favorites: [Favourite]
    
    // MARK: Inits
    init(favorites: [Favourite] = []) {
        self.favorites = favorites
    }
    func add(favourite: Favourite) {
        favorites.append(favourite)
    }
    func remove(favourite: Favourite) {

    }
    
    func count() -> Int {
        return self.favorites.count
    }
    
    func lists() {
        print("lista de favoritos")
        favorites.forEach { favourite in
            print (favourite.name)
        }
    }
}
