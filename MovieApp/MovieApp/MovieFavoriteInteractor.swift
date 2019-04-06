//
//  MovieFavoriteInteractor.swift
//  MovieApp
//
//  Created by Sebastian Diaz on 4/6/19.
//  Copyright © 2019 Accenture. All rights reserved.
//

import Foundation
import RealmSwift

protocol MovieFavoriteInteractorProtocol {
    func fetchMovies()
}



class MovieFavoriteInteractor {
    var presenter : MovieFavoritePresenter?
    
    
}

extension MovieFavoriteInteractor: MovieFavoriteInteractorProtocol {
    
    func fetchMovies() {
        do{
            let realm = try Realm()
            let movies = realm.objects(Movie.self)
            presenter?.onFetchFavoriteMovieSuccess(movies.toArray(ofType: Movie.self), shouldAppend: true)
        }catch let error {
            //TODO - crash error
        }
       
    }

}
