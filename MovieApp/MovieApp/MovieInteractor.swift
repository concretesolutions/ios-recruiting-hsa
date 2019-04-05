//
//  MovieInteractor.swift
//  MovieApp
//
//  Created by Sebastian Diaz on 4/3/19.
//  Copyright © 2019 Accenture. All rights reserved.
//

import Foundation
protocol MovieInteractorProtocol : class {
    
    var  presenter : MoviePresenter? { get set }
    func getMovies()
}


class MovieInteractor : MovieInteractorProtocol {
    
    var presenter : MoviePresenter?
//    var movieAPIService : Movie
    
    
    func attachPresenter(presenter : MoviePresenter){
        self.presenter = presenter
    }
    

    func getMovies()->Void {
        sleep(5)
        var movies = [
            Movie(title: "Pelicula1", releaseDate:  "2018-11-11", genres: [Genre(id: 1, name: "PORNO"),Genre(id: 2, name: "PORNO2")], overview: "EXELENTE"),
            Movie(title: "Pelicula2", releaseDate:  "2018-11-11", genres: [Genre(id: 1, name: "PORNO"),Genre(id: 2, name: "PORNO2")], overview: "EXELENTE"),
            Movie(title: "Pelicula3", releaseDate:  "2018-11-11", genres: [Genre(id: 1, name: "PORNO"),Genre(id: 2, name: "PORNO2")], overview: "EXELENTE"),
            Movie(title: "Pelicula4", releaseDate:  "2018-11-11", genres: [Genre(id: 1, name: "PORNO"),Genre(id: 2, name: "PORNO2")], overview: "EXELENTE"),
            Movie(title: "Pelicula5", releaseDate:  "2018-11-11", genres: [Genre(id: 1, name: "PORNO"),Genre(id: 2, name: "PORNO2")], overview: "EXELENTE"),
            Movie(title: "Pelicula6", releaseDate:  "2018-11-11", genres: [Genre(id: 1, name: "PORNO"),Genre(id: 2, name: "PORNO2")], overview: "EXELENTE"),
            Movie(title: "Pelicula7", releaseDate:  "2018-11-11", genres: [Genre(id: 1, name: "PORNO"),Genre(id: 2, name: "PORNO2")], overview: "EXELENTE"),
            Movie(title: "Pelicula8", releaseDate:  "2018-11-11", genres: [Genre(id: 1, name: "PORNO"),Genre(id: 2, name: "PORNO2")], overview: "EXELENTE")

        ]
        presenter?.onFetchMovieSuccess(movies, shouldAppend: true)
    }
    
}
