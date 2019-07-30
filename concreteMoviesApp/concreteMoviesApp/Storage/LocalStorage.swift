//
//  LocalStorage.swift
//  concreteMoviesApp
//
//  Created by Nebraska Melendez on 7/28/19.
//  Copyright © 2019 Nebraska Melendez. All rights reserved.
//

import Foundation


class LocalStorage{
    
    static let moviesKey = "MoviesKey"
    
    class  func favoriteMovie(save movie: MovieModel){
        
        var allMovies = self.getFavoritesMovies()
        allMovies.insert(movie, at: 0)
        
        let encoder = JSONEncoder()
        
        if let encoded = try? encoder.encode(allMovies){
            UserDefaults.standard.set(encoded, forKey: LocalStorage.moviesKey)
        }
        
    }
    
    class  func getFavoritesMovies() -> [MovieModel]{
        
        guard let encodedMovies = UserDefaults.standard.data(forKey: LocalStorage.moviesKey)else{
            return []
        }
        
        let decoder = JSONDecoder()
        
        if let allMovies = try? decoder.decode([MovieModel].self, from: encodedMovies){
            return allMovies
        }
        
        return []
    }
    
    class  func favoriteMovie(delete movie: MovieModel){
        
        var allMovies = self.getFavoritesMovies()
        
        allMovies.removeAll { (m) -> Bool in
            return m.id == movie.id
        }
        
        let encoder = JSONEncoder()
        
        if let encoded = try? encoder.encode(allMovies){
            UserDefaults.standard.set(encoded, forKey: LocalStorage.moviesKey)
        }
    }
}
