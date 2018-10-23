//
//  FavoritosPresenter.swift
//  TestProject
//
//  Created by Felipe S Vergara on 21-10-18.
//  Copyright © 2018 MyOwnCompany. All rights reserved.
//

import Foundation


protocol FavoriteEventReponse{
    func favoritesLoaded(favorites: [Movie])
    func favoriteRemoved(favorites: [Movie])
}

class FavoritesPresenter{
    
    var presenterResponse:FavoriteEventReponse?
    var model:MovieModel?
    
    //Forzar para que se inicie siempre con el delegate puesto
    init(delegate: FavoriteEventReponse) {
        self.presenterResponse = delegate
        //Se inicia la conexion con model
        self.doInit()
    }
    
    
    func doInit(){
        self.model = MovieModel()
        //delegate
        self.model?.movieModelResponse = self
    }
    
    func loadFavorites(){
        self.model?.loadMovieFromFavorites()
    }
    
    func removeFavorite(movie:Movie){
        self.model?.removeMovieFromFavorite(movie: movie)
    }
    
}

//MARK: - Response from MODEL to PRESENTER
extension FavoritesPresenter: MovieModelResponse{
    func removedFavorite(newFavorites: [Movie]) {
        self.presenterResponse?.favoriteRemoved(favorites: newFavorites)
    }
    
    func onLoadError() {
        
    }
    
    func onLoadSuccess(movieList: [Movie]) {
        
    }
    
    func showLoading(show: Bool) {
        
    }
    
    func onLoadSuccess(genres: [Genre]) {
        
    }
    
    func onLoadFavorites(favorites: [Movie]) {
        self.presenterResponse?.favoritesLoaded(favorites: favorites)
    }
    
    func savedFavorites() {
        
    }
    
}
