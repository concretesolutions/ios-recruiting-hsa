//
//  DetailMoviePresenter.swift
//  TestProject
//
//  Created by Felipe S Vergara on 21-10-18.
//  Copyright © 2018 MyOwnCompany. All rights reserved.
//

import Foundation

protocol DetailMovieEventResponse{
    func attachDate(newDate:String)
    func genreLoaded(genreString: String)
    func favoritesLoaded(isFav: Bool)
    func favoriteSaved()
    func favoriteRemoved()
    func showLoading(show:Bool)
    
}

class DetailMoviePresenter{
    
    var presenterResponse: DetailMovieEventResponse?
    var model:MovieModel?
    var movieToCheck:Movie?
    
    //Forzar para que se inicie siempre con el delegate puesto
    init(delegate: DetailMovieEventResponse) {
        self.presenterResponse = delegate
        doInit()
    }
    
    func doInit(){
        self.model = MovieModel()
        self.model?.movieModelResponse = self
        
    }
    
    func getMovieGenre(genres: [Int]){
        self.model?.getMovieGenresFromAPI(fromGenre: genres)
    }
    
    func addFavorite(movie:Movie){
        self.model?.saveMovieToFavorites(movie: movie)
    }
    
    func loadFavorites(movieToCheck:Movie){
        self.movieToCheck = movieToCheck
        self.model?.loadMovieFromFavorites()
    }
    
    func removeFavorite(movie:Movie){
        self.model?.removeMovieFromFavorite(movie: movie)
    }
    
}

extension DetailMoviePresenter: MovieModelResponse{
    func removedFavorite(newFavorites: [Movie]) {
        self.presenterResponse?.favoriteRemoved()
    }
    
    func onLoadFavorites(favorites: [Movie]) {
        for favorite in favorites{
            if favorite.id == self.movieToCheck?.id{
                self.presenterResponse?.favoritesLoaded(isFav: true)
                return
            }
        }
        self.presenterResponse?.favoritesLoaded(isFav: false)
    }
    
    func savedFavorites() {
        self.presenterResponse?.favoriteSaved()
    }
    
    func onLoadSuccess(genres: [Genre]) {
        let str = genres.map({$0.name}).joined(separator: " - ")
        self.presenterResponse?.genreLoaded(genreString: str)
    }
    func onLoadError() {
    }
    func onLoadSuccess(movieList: [Movie]) {}
    
    func showLoading(show: Bool) {
        self.presenterResponse?.showLoading(show: show)
    }
}


extension DetailMoviePresenter{
    
    func formatDateFrom(dateToFormat:String){
        var formattedDate = ""
        
        let dateFormatterGet = DateFormatter()
        dateFormatterGet.dateFormat = "yyyy-MM-dd"
        
        let dateFormatterPrint = DateFormatter()
        dateFormatterPrint.dateFormat = "yyyy"
        
        if let date = dateFormatterGet.date(from: dateToFormat) {
            formattedDate = dateFormatterPrint.string(from: date)
        } else {
            print("There was an error decoding the string")
        }
        
        self.presenterResponse?.attachDate(newDate: formattedDate)
    }
    
}
