//
//  MovieFavoriteInteractor.swift
//  MovieApp
//
//  Created by Sebastian Diaz on 4/6/19.
//  Copyright © 2019 Accenture. All rights reserved.
//

import Foundation
import RealmSwift
import Crashlytics

protocol MovieFavoriteInteractorProtocol {
    func fetchMovies()
    func unFavoriteMovie(movieDelete: MovieViewModel)
}



class MovieFavoriteInteractor {
    var presenter : MovieFavoritePresenter?
    
    
}

extension MovieFavoriteInteractor: MovieFavoriteInteractorProtocol {
    func unFavoriteMovie(movieDelete: MovieViewModel) {
        do{
            let realm = try Realm()
            let movies = realm.objects(Movie.self)
            for movie in movies {
                if movie.id == movieDelete.id{
                    realm.beginWrite()
                    realm.delete(movie)
                    try realm.commitWrite()
                }
            }
            presenter?.onDeleteMovieSuccess()
        }catch let error {
            Crashlytics.sharedInstance().recordError(error)
        }
    }
    
    
    func fetchMovies() {
        do{
            let realm = try Realm()
            let movies = realm.objects(Movie.self)
            presenter?.onFetchFavoriteMovieSuccess(movies.toArray(ofType: Movie.self), shouldAppend: true)
        }catch let error {
            Crashlytics.sharedInstance().recordError(error)
        }
       
    }

}
