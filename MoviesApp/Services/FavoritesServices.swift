//
//  FavoritesServices.swift
//  MoviesApp
//
//  Created by Hector Morales on 2/28/21.
//

import Foundation

class FavoritesAPI {

    func saveSingleFavorite(movie: Movie) {
        let encoder = JSONEncoder()
        let defaults = UserDefaults.standard
        if let favoriesArray = loadFavorites(), !existsFavoriteInStorage(movie: movie) {
            var aux = favoriesArray
            aux.append(movie)
            if let encoded = try? encoder.encode(aux) {
                defaults.set(encoded, forKey: UserDefaultsKeys.favoritesArrayCache)
            }
        } else if !existsFavoriteInStorage(movie: movie)  {
            var moviesArray: [Movie] = []
            moviesArray.append(movie)
            if let encoded = try? encoder.encode(moviesArray) {
                defaults.set(encoded, forKey: UserDefaultsKeys.favoritesArrayCache)
            }
        }
    }

    func loadFavorites() -> [Movie]? {
        if let savedFavorites = UserDefaults.standard.object(forKey: UserDefaultsKeys.favoritesArrayCache) as? Data {
            let decoder = JSONDecoder()
            if let loadedFavorites = try? decoder.decode([Movie].self, from: savedFavorites) {
                return loadedFavorites
            }
        }
        return nil
    }

    func existsFavoriteInStorage(movie: Movie) -> Bool {
        if let favoritesArray = loadFavorites() {
            for favorite in favoritesArray {
                if favorite.id == movie.id {
                    return true
                }
            }
        }
        return false
    }

    func deleteFavoriteMovie(movieId: Int?){
        guard let favoritesArray = loadFavorites() else { return }
        let encoder = JSONEncoder()
        let favoritesClean = favoritesArray.filter({$0.id != movieId})
        if let encoded = try? encoder.encode(favoritesClean) {
            UserDefaults.standard.set(encoded, forKey: UserDefaultsKeys.favoritesArrayCache)
        }
    }
}
