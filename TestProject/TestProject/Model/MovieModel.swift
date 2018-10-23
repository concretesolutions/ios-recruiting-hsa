//
//  Movie.swift
//  TestProject
//
//  Created by Felipe S Vergara on 20-10-18.
//  Copyright © 2018 MyOwnCompany. All rights reserved.
//

import Foundation
import SVProgressHUD

//Response from this class by events(protocols) to presenter
protocol MovieModelResponse{
    func onLoadError()
    func onLoadSuccess(movieList:[Movie])
    func showLoading(show:Bool)
    func onLoadSuccess(genres:[Genre])
    func onLoadFavorites(favorites:[Movie])
    func savedFavorites()
    func removedFavorite(newFavorites:[Movie])
}

class MovieModel{
    //Delegate
    var movieModelResponse : MovieModelResponse?
    //File name to save
    var fileName = "Favoritos"
    
    init(isTest:Bool? = nil){
        if let test = isTest{
            fileName = test ? "TestFavoritos" : fileName
        }
    }
    
    //Get all movies from API
    func getAllMovies(){
        self.movieModelResponse?.showLoading(show: true)
        APIManager.shared.getMovies(completition: { (movie) in
            if let mov = movie{
                self.movieModelResponse?.onLoadSuccess(movieList: mov)
            }else{
                self.movieModelResponse?.onLoadError()
            }
            self.movieModelResponse?.showLoading(show: false)
        }) { (error) in
            print(error)
            self.movieModelResponse?.showLoading(show: false)
            self.movieModelResponse?.onLoadError()
        }
    }
    
    //Filter movies by search term
    func getFilteredMovies(moviesToFilter: [Movie], bySearchTerm: String) -> [Movie]{
        return moviesToFilter.filter({
            return $0.title.localizedCaseInsensitiveContains(bySearchTerm)
        })
    }
    
    //Get genres from API and then we filter it to get name of those genre's id
    func getMovieGenresFromAPI(fromGenre: [Int]){
        self.movieModelResponse?.showLoading(show: true)
        APIManager.shared.getGenres(completition: { (genre) in
            if let gen = genre{
                var temp = [Genre]()
                //filter
                if fromGenre.count > 0{
                    for idx in 0...fromGenre.count-1{
                        temp.append(gen.filter({$0.id == fromGenre[idx]}).first!)
                    }
                }
                self.movieModelResponse?.onLoadSuccess(genres: temp)
                self.movieModelResponse?.showLoading(show: false)
            }
        }) { (error) in
            self.movieModelResponse?.onLoadError()
            print(error)
            self.movieModelResponse?.showLoading(show: false)
            self.movieModelResponse?.onLoadError()
        }
    }
    
    //Save movies to Favorites
    func saveMovieToFavorites(movie:Movie){
        var tempMovie = [Movie]()
        if Storage.fileExists(fileName, in: .documents){
            tempMovie = Storage.retrieve(fileName, from: .documents, as: [Movie].self)
        }
        tempMovie.append(movie)
        Storage.store(tempMovie, to: .documents, as: fileName)
        self.movieModelResponse?.savedFavorites()
    }
    
    //Load movies from Favotrites
    func loadMovieFromFavorites(){
        var tempMovie = [Movie]()
        tempMovie = Storage.fileExists(fileName, in: .documents) ? Storage.retrieve(fileName, from: .documents, as: [Movie].self) : []
        self.movieModelResponse?.onLoadFavorites(favorites: tempMovie)
    }
    
    //Remove movies from favortie
    func removeMovieFromFavorite(movie:Movie){
        var tempMovie = [Movie]()
        if Storage.fileExists(fileName, in: .documents){
            tempMovie = Storage.retrieve(fileName, from: .documents, as: [Movie].self)
            tempMovie.removeAll(where: {$0.id == movie.id})
            Storage.store(tempMovie, to: .documents, as: fileName)
            self.movieModelResponse?.removedFavorite(newFavorites: tempMovie)
        }else{
            self.movieModelResponse?.onLoadError()
        }
        
    }
}


//Entidad
struct Movie: Codable {
    let voteCount, id: Int
    let video: Bool
    let voteAverage: Double
    let title: String
    let popularity: Double
    let posterPath: String
    let originalTitle: String
    let genreIDS: [Int]
    let backdropPath: String
    let adult: Bool
    let overview, releaseDate: String
    
    enum CodingKeys: String, CodingKey {
        case voteCount = "vote_count"
        case id, video
        case voteAverage = "vote_average"
        case title, popularity
        case posterPath = "poster_path"
        case originalTitle = "original_title"
        case genreIDS = "genre_ids"
        case backdropPath = "backdrop_path"
        case adult, overview
        case releaseDate = "release_date"
    }
    
    func getUrlImage() -> URL{
        return URL(string: "\(Config.posterPathBase)\(posterPath)")!
    }
}


struct Genre: Codable {
    let id: Int
    let name: String
}
