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
    var favorites: Set<Favourite> = []
    var favoriteChange: Bool = false
    
    // MARK: Method
    func add(favourite: Favourite) {
        favorites.insert(favourite)
        favoriteChange = true
    }
    func getById(id: Int) -> Favourite? {
        let _favorites = favorites.first(where: { $0.id == id })
        return _favorites
        
    }
    func remove(favourite: Favourite) {
        favorites.remove(favourite)
        favoriteChange = true
    }
    func favoriteChangeOff() {
        favoriteChange = false
    }
    func setToArray() -> [Favourite] {
        return Array(favorites)
    }
    
    func count() -> Int {
        return self.favorites.count
    }
    
    func lists() {
        print("lista de favoritos: \(favorites.count)")
        favorites.forEach { favourite in
            print (favourite.id)
            print (favourite.name)
            print (favourite.image)
            print (favourite.releaseDate)
            print (favourite.synopsis)
            print ("----")
        }
    }
}
