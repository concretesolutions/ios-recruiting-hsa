//
//  MovieInteractor.swift
//  MovieApp
//
//  Created by Sebastian Diaz on 4/3/19.
//  Copyright © 2019 Accenture. All rights reserved.
//

import Foundation
import RealmSwift
import Realm


protocol MovieInteractorProtocol : class {
    
    var  presenter : MoviePresenter? { get set }
    func getAPIMovies()
    func foundFavorities(_ movies: [Movie])
    func getLocalMovies() -> [Movie?]
    
}

class MovieInteractor {
    var presenter : MoviePresenter?
    
    func attachPresenter(presenter : MoviePresenter){
        self.presenter = presenter
    }
}

extension MovieInteractor : MovieInteractorProtocol {

    func getLocalMovies() -> [Movie?] {
        do{
            let realm = try Realm()
            let farovites = realm.objects(Movie.self)
            let arrayMovies = farovites.toArray(ofType: Movie.self)
            return arrayMovies
        }catch let error {
//           catch Error
            return []
        }
    }
    
    func getAPIMovies()->Void {
        MovieAPIService.shared.getPopularMovies(success: { (data) in
            do {
                let dataJson = try JSONSerialization.data(withJSONObject: data, options:.prettyPrinted)
                let movies = try JSONDecoder().decode([Movie].self, from:dataJson)
                self.foundFavorities(movies)
                self.presenter?.onFetchMovieSuccess(movies, shouldAppend: true)
            } catch let error {
                //TODO - crash error
                print(error)
            }
        }, fail: { (error) in
            self.presenter?.fetchMovieFailure(message: error)
        }, timeout: {
            self.presenter?.fetchMovieTimeOut()
        })
    }
    
    func foundFavorities(_ movies: [Movie]){
        let arrayMovies = self.getLocalMovies()
        let ids = arrayMovies.map{$0!.id}
        let _ = movies.compactMap({ (movie) -> Movie? in
            if ids.contains(movie.id){
                movie.favorite = true
            }
            return movie
        })
 
    }
    
    
}
