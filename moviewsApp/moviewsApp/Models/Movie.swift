
import Foundation
import SwiftyJSON
import CoreData

class Movie{
    
    static var favorites = [Favorites]()
    
    var voteCount : Int?
    var id : Int?
    var video : Bool?
    var voteAverage : Double?
    var title : String?
    var popularity : Double?
    var posterPath : String?
    var originalLanguage : String?
    var genreIds : [Int]?
    var backdropPath : String?
    var isAdults : Bool?
    var overview : String?
    var releaseDate : String?
    
    init(jsonData : JSON) {
        self.voteCount = jsonData["vote_count"].exists() ? jsonData["vote_count"].int : 0
        self.id = jsonData["id"].exists() ? jsonData["id"].int : 0
        self.video = jsonData["video"].exists() ? jsonData["video"].bool : false
        self.voteAverage = jsonData["vote_average"].exists() ? jsonData["vote_average"].double : 0
        self.title = jsonData["title"].exists() ? jsonData["title"].string : ""
        self.popularity = jsonData["popularity"].exists() ? jsonData["popularity"].double : 0
        self.posterPath = jsonData["poster_path"].exists() ? jsonData["poster_path"].string : ""
        self.originalLanguage = jsonData["original_language"].exists() ? jsonData["vote_count"].string : ""
        if let array = jsonData["genre_ids"].array{
            self.genreIds = []
            for json in array{
                guard let id = json.int else{
                    return
                }
                self.genreIds!.append(id)
            }
        }
        self.backdropPath = jsonData["backdrop_path"].exists() ? jsonData["backdrop_path"].string : ""
        self.isAdults = jsonData["adult"].exists() ? jsonData["adult"].bool : false
        self.overview = jsonData["overview"].exists() ? jsonData["overview"].string : ""
        self.releaseDate = jsonData["release_date"].exists() ? jsonData["release_date"].string : ""
    }
    
    init(favorite : Favorites) {
        self.id = favorite.id.hashValue
        self.voteCount = favorite.voteCount.hashValue
        self.video = favorite.video
        self.voteAverage = favorite.voteAverage
        self.title = favorite.title
        self.popularity = favorite.popularity
        self.posterPath = favorite.posterPath
        self.originalLanguage = favorite.originalLanguage
        self.backdropPath = favorite.backdropPath
        self.isAdults = favorite.isAdults
        self.overview = favorite.overview
        self.releaseDate = favorite.releaseDate
        self.genreIds = favorite.genreIds as? [Int]
    }
    
    
    /// trae las peliculas del store
    static func loadFavoritesFromStore(){
    
        let fetchResults : NSFetchRequest<Favorites> = Favorites.fetchRequest()
        do {
            let movies = try PersistenceService.context.fetch(fetchResults)
            self.favorites = movies
        } catch{
        }
    }
    
    
    /// guarda la pelicula en las favoritas
    ///
    /// - Parameter movie: data para crear el objeto Favorites para guardarlo en core data
    static func saveFavoriteMovie(movie : Movie){
        let favoriteMovie = Favorites(context: PersistenceService.context)
        favoriteMovie.id = Int64(movie.id!)
        favoriteMovie.voteCount = Int64(movie.voteCount!)
        favoriteMovie.video = movie.video!
        favoriteMovie.voteAverage = movie.voteAverage!
        favoriteMovie.title = movie.title
        favoriteMovie.popularity = movie.popularity!
        favoriteMovie.posterPath = movie.posterPath
        favoriteMovie.originalLanguage = movie.originalLanguage
        favoriteMovie.backdropPath = movie.backdropPath
        favoriteMovie.isAdults = movie.isAdults!
        favoriteMovie.overview = movie.overview
        favoriteMovie.releaseDate = movie.releaseDate
        favoriteMovie.genreIds = movie.genreIds! as NSArray
        PersistenceService.saveContext()
        loadFavoritesFromStore()
    }
    
    
    /// elimina la palicula de las favoritas
    ///
    /// - Parameter id: id de la pelicula
    static func removeFavoriteMovie(withID id : Int){
        let fetchResults : NSFetchRequest<Favorites> = Favorites.fetchRequest()
        fetchResults.predicate = NSPredicate.init(format: "id==\(id)")
        do {
            let movies = try PersistenceService.context.fetch(fetchResults)
            for obj in movies {
                PersistenceService.context.delete(obj)
            }
        } catch{
        }
        PersistenceService.saveContext()
        loadFavoritesFromStore()
    }
}
