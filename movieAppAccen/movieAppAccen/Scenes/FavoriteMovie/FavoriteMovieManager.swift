//
//  FavoriteMovieManager.swift
//  movieAppAccen
//
//  Created by Orlando Velasco on 22-10-23.
//

import Foundation
import CoreData

class FavoriteMovieManager {
    
    private let context = CoreDataManager.shared.container.viewContext
    
    func fetchAllFavorites() -> [FavoriteMovie] {
        let fetchRequest: NSFetchRequest<FavoriteMovie> = FavoriteMovie.fetchRequest()
        do {
            let favorites = try context.fetch(fetchRequest)
            return favorites
        } catch {
            print("Error: \(error.localizedDescription)")
            return []
        }
    }
    
    func addFavorite(movie: Movies.FetchMovies.ViewModel.DisplayedMovie) {
        let favorite = FavoriteMovie(context: context)
        favorite.id = Int64(movie.id)
        favorite.title = movie.title
        favorite.posterPath = movie.posterPath
        favorite.overview = movie.overview
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        if let releaseDate = dateFormatter.date(from: movie.releaseDate) {
            favorite.releaseDate = releaseDate
        }
        
        CoreDataManager.shared.saveContext()
    }
    
    func removeFavorite(by movieId: Int) {
        let fetchRequest: NSFetchRequest<FavoriteMovie> = FavoriteMovie.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "id == %d", movieId)
        
        do {
            let favorites = try context.fetch(fetchRequest)
            for favorite in favorites {
                context.delete(favorite)
            }
            CoreDataManager.shared.saveContext()
        } catch {
            print("Error: \(error.localizedDescription)")
        }
    }
    
    func isFavorite(movieId: Int) -> Bool {
        let fetchRequest: NSFetchRequest<FavoriteMovie> = FavoriteMovie.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "id == %d", movieId)
        
        do {
            let favorites = try context.fetch(fetchRequest)
            return !favorites.isEmpty
        } catch {
            print("Error: \(error.localizedDescription)")
            return false
        }
    }
}

