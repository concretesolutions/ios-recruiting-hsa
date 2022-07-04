//
//  FavoritesManager.swift
//  iOS-movieApp
//
//  Created by alvaro.concha on 04-07-22.
//

import Foundation


class FavManagerSingleton{
    let userDefaults = UserDefaults.standard
    var favoritesMovies : [MovieResult] = []
    var idsFavoriteMovies : [Int] = []
    var popularMovies : [MovieResult] = []
    
    
    
 
    
    static var shared: FavManagerSingleton = {
        let instance = FavManagerSingleton()
        return instance
    }()
    
    private init(){
        let apiManager = APIManager()

        apiManager.getPopularMovies { (MovieResult) in

            guard let movie = MovieResult else{ return }
            self.popularMovies = movie
        }
        
        
        DispatchQueue.main.asyncAfter(deadline: .now()+1) {
            
            if let arrayIds : [Int] = self.userDefaults.object(forKey: "idsFavoriteMovies") as? [Int]{
            self.idsFavoriteMovies = arrayIds

                self.parseArrMovies(ids: self.idsFavoriteMovies)
                
//                print("Singleton_Favs: ", self.favoritesMovies)
//                print("Singleton_ids: ",arrayIds)
                
                
                
            }
            
            
        }
    }
    
    func checkFavoriteMovies() -> Bool{
        guard let favorite = userDefaults.object(forKey: "idsFavoriteMovies") as? [Int] else { return false }
        idsFavoriteMovies = favorite
        return true
    }
    
    func addMovieToFavorites(movie : MovieResult){
        
        if !idsFavoriteMovies.contains(movie.id){
            
            idsFavoriteMovies.append(movie.id)
            
            userDefaults.set(idsFavoriteMovies, forKey: "idsFavoriteMovies")
            userDefaults.synchronize()
            
            
            favoritesMovies.append(movie)
            
            print("LOG_: Singleton: idsFavoriteMovies: ", idsFavoriteMovies)
            print("LOG_: Singleton: favoritesMovies: ", favoritesMovies)

        }
        
        print("ya existe la pelicula en favoritos")
        
    }
    
    func deleteMovieFromFavorites(movieIndex : Int, movieDeleted : MovieResult){
        //hay que eliminar de favoritesMovies y idsFavoritesMovies
        idsFavoriteMovies.remove(at: movieIndex)
        userDefaults.set(idsFavoriteMovies, forKey: "idsFavoriteMovies")
        userDefaults.synchronize()
        
        
        for (i , favMovie) in favoritesMovies.enumerated() {
            if favMovie.id == movieDeleted.id{
                favoritesMovies.remove(at: i )
            }
        }
        
    }
    
    func parseArrMovies(ids : [Int]){
        for id in ids {
            for movie in self.popularMovies {
                if movie.id == id {
                    self.favoritesMovies.append(movie)
                }
            }
        }
        
    }
}


//SINGLETON debe contener los metodos que persisten los favoritos
