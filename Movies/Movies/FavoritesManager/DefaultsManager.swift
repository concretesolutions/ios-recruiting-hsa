//
//  DefaultsManager.swift
//  Movies
//
//  Created by Consultor on 12/14/18.
//  Copyright © 2018 Mavzapps. All rights reserved.
//

import Foundation

public class DefaultsManager {
    
    public static var shared = DefaultsManager()
    
    //let userDefaults =
    
    let favoritesKey = "favoriteMovies"
    
    var favoriteMovies: [Movie] = []
    
    init(){
        getFavorites()
    }
    
    func getFavorites(){
        //userDefaults.
        if let encodedObjectJsonString = UserDefaults.standard.string(forKey: favoritesKey){
            if let jsonData = encodedObjectJsonString.data(using: .utf8){
                if let favoriteMovies = try? JSONDecoder().decode([Movie].self, from: jsonData){
                    self.favoriteMovies = favoriteMovies
                } else {
                    print("Error retrieving favorites")
                }
            }
        }
    }
    
    func isMovieFavorite(_ movie: Movie) -> Bool {
        //getFavorites()
        return favoriteMovies.contains(where: {$0.id == movie.id})
    }
    
    private func updateFavorites(){
        if let encodedObject = try? JSONEncoder().encode(favoriteMovies){
            if let encodedObjectJsonString = String(data: encodedObject, encoding: .utf8)
            {
                UserDefaults.standard.set(encodedObjectJsonString, forKey: favoritesKey)
            }
        }
    }
    
    func addFavorite(_ movie: Movie){
        favoriteMovies.append(movie)
        updateFavorites()
    }
    
    func removeFavorite(_ movie: Movie){
        if let index = favoriteMovies.firstIndex(where: {$0.id == movie.id}) {
            favoriteMovies.remove(at: index)
            updateFavorites()
        }
        
    }
}
