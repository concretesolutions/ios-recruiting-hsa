//
//  FavoritesManager.swift
//  GetMovieApp
//
//  Created by Training on 04-07-22.
//

import Foundation
class FavoritesManager {
    
    //MARK: Singleton
    static let shared = FavoritesManager()
    
    //MARK: Properties
    var moviesFavorites: [Favorites] = []
    
//    init(movieFavorites: [Favorites]) {
//        self.moviesFavorites = movieFavorites
//    }
    
    //MARK: Method
    func addMovieFavorite(movies: Favorites){
        moviesFavorites.append(movies)
    }
    func printConsole() {
        moviesFavorites.forEach { movie in
            print(movie.id)
        }
    }
    
}
