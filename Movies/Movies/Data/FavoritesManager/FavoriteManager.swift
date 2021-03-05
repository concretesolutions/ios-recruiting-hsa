//
//  FavoriteManager.swift
//  Movies
//
//  Created by Daniel Nunez on 04-03-21.
//

import Foundation

class FavoriteManager {

    private var favoritesKey = "favorites"
    private var genresKey = "genres"

    func save(movie: Movie) {

        let encoder = JSONEncoder()
        let defaults = UserDefaults.standard
        if let favorites = getFavorites(), !checkFavorite(movie: movie) {
            var temp = favorites
            temp.append(movie)

            if let movies = try? encoder.encode(temp) {
                defaults.set(movies, forKey: favoritesKey)
            }

        } else if !checkFavorite(movie: movie)  {
            var moviesArray: [Movie] = []
            moviesArray.append(movie)
            if let encoded = try? encoder.encode(moviesArray) {
                defaults.set(encoded, forKey: favoritesKey)
            }
        }

    }
    func getFavorites() -> [Movie]? {
        if let savedFavorites = UserDefaults.standard.object(forKey: favoritesKey) as? Data {
            let decoder = JSONDecoder()
            if let loadedFavorites = try? decoder.decode([Movie].self, from: savedFavorites) {
                return loadedFavorites
            }
        }
        return nil
    }

    func checkFavorite(movie: Movie) -> Bool {

        if let favoritesArray = getFavorites() {
            for favorite in favoritesArray {
                if favorite.id == movie.id {
                    return true
                }
            }
        }
        return false

    }

    func delete(by id: Movie.Identifier) {
        guard let array = getFavorites() else { return }
        let encoder = JSONEncoder()
        let filter = array.filter({$0.id != id})
        if let encoded = try? encoder.encode(filter) {
            UserDefaults.standard.set(encoded, forKey: favoritesKey)
        }
    }
}
