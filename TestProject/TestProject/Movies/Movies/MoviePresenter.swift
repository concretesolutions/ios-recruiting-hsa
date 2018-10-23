//
//  File.swift
//  TestProject
//
//  Created by Felipe S Vergara on 21-10-18.
//  Copyright © 2018 MyOwnCompany. All rights reserved.
//

import Foundation


protocol MovieEventResponse{
    func moviesLoaded(movieList: [Movie])
    func isFiltering(filtering:Bool)
    func moviesFiltered(filteredMovies: [Movie])
    func favoritesLoaded(favorites:[Movie])
    func favoritesSaved()
    func favoriteRemoved()
    func showLoading(show:Bool)
}


class MoviePresenter{
    
    var presenterResponse: MovieEventResponse?
    var model:MovieModel?
    
    //Force delegates
    init(delegate: MovieEventResponse) {
        self.presenterResponse = delegate
        
        self.doInit()
    }
    
}

//MARK: - Functionality
extension MoviePresenter{
    //Init model
    func doInit(){
        self.model = MovieModel()
        //delegate
        self.model?.movieModelResponse = self
        //Fetch Movies
        fetchMovies()
    }
    
    //Get all movies from model
    func fetchMovies(){
        self.model?.getAllMovies()
    }
    
    //Filter movies from model and send by an event to view
    func searchTextInMovies(searchText:String, movies: [Movie]){
        if searchText.isEmpty {
            self.presenterResponse?.isFiltering(filtering: false)
        } else {
            self.presenterResponse?.isFiltering(filtering: true)
            let filteredMovies = self.model?.getFilteredMovies(moviesToFilter: movies, bySearchTerm: searchText) ?? []
            self.presenterResponse?.moviesFiltered(filteredMovies: filteredMovies)
        }
    }
    //Set filter true/false
    func setFilter(isFiltering:Bool){
        self.presenterResponse?.isFiltering(filtering: isFiltering)
    }
    //Used when users press on favorite button
    func addFavorite(movie:Movie){
        self.model?.saveMovieToFavorites(movie: movie)
    }
    //Load all favoritos from model to compare it with actual array of movies
    func loadFavorites(){
        self.model?.loadMovieFromFavorites()
    }
    //Used when users press on favorite button
    func removeFavorite(movie:Movie){
        self.model?.removeMovieFromFavorite(movie: movie)
    }

}

//MARK: - Response from MODEL to PRESENTER
extension MoviePresenter: MovieModelResponse{
    func removedFavorite(newFavorites: [Movie]) {
        self.presenterResponse?.favoriteRemoved()
    }
    
    func onLoadFavorites(favorites: [Movie]) {
        self.presenterResponse?.favoritesLoaded(favorites: favorites)
    }
    
    func savedFavorites() {
        self.presenterResponse?.favoritesSaved()
    }
    
    func onLoadSuccess(genres: [Genre]) {
    }
    
    func onLoadSuccess(movieList: [Movie]) {
        self.presenterResponse?.moviesLoaded(movieList: movieList)
    }
    
    func onLoadError() {
    }
    
    func showLoading(show: Bool) {
        self.presenterResponse?.showLoading(show: show)
    }
    
}
