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
    
    func attachPresenter(presenter : MoviePresenter){
        self.presenter = presenter
    }
    
    func getMovies()->Void {
        MovieAPIService.shared.getPopularMovies { (data) in
            do {
                let dataJson = try JSONSerialization.data(withJSONObject: data, options:.prettyPrinted)
                let movies = try JSONDecoder().decode([Movie].self, from:dataJson)
                self.presenter?.onFetchMovieSuccess(movies, shouldAppend: true)
            } catch let error {
                //CRASH ERROR
                
            }
        }
    }
    
    func getDetailMovie(id : Int){
        
    }
    
}
