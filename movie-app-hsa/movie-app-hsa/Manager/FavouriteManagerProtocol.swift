//
//  FavouriteManagerProtocol.swift
//  movie-app-hsa
//
//  Created by training on 03-07-22.
//

import Foundation

protocol FavouriteManagerProtocol {

    // MARK: Properties
    var favorites: Set<Favourite> { get set}
    var favoriteChange: Bool { get }
    
    // MARK: Methods
    func add(favourite: Favourite)
    func remove(favourite: Favourite)
    func count() -> Int
    func lists()
    func favoriteChangeOff()
    func setToArray() -> [Favourite]
    
}
