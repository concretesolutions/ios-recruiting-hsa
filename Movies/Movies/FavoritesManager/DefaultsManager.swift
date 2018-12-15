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
    
    let userDefaults = UserDefaults.standard
    
    let favoritesKey = "favoriteMovies"
    
    var favoriteMovies: [Movie]? = []
    
    func getFavorites() -> [Movie]{
        //userDefaults.
        if let encodedObjectJsonString = userDefaults.string(forKey: favoritesKey){
            if let jsonData = encodedObjectJsonString.data(using: .utf8){
                favoriteMovies = try? JSONDecoder().decode([Movie].self, from: jsonData)
                return favoriteMovies ?? []
            }
        }
        return []
    }
    
    private func updateFavorites(){
        if let encodedObject = try? JSONEncoder().encode(favoriteMovies){
            if let encodedObjectJsonString = String(data: encodedObject, encoding: .utf8)
            {
                userDefaults.set(encodedObjectJsonString, forKey: favoritesKey)
            }
        }
    }
    
    func addFavorite(_ movie: Movie){
        favoriteMovies?.append(movie)
        updateFavorites()
    }
    
    func removeFavorite(_ movie: Movie){
        if let index = favoriteMovies?.firstIndex(where: {$0.id == movie.id}) {
            favoriteMovies?.remove(at: index)
            updateFavorites()
        }
        
    }
}
