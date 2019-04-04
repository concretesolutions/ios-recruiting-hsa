//
//  MoviePresenter.swift
//  MovieApp
//
//  Created by Sebastian Diaz on 4/3/19.
//  Copyright © 2019 Accenture. All rights reserved.
//

import Foundation

protocol MoviePresenterProtocol {
    func showMovies(_ completion: ([MovieViewModel]))
    func showMovieDetail(for viewModel: MovieViewModel)
}

class MoviePresenter : MoviePresenterProtocol{
    
    var movieView : MovieViewProtocol?
    let interactor : MovieInteractorProtocol
    let router : MovieRouterProtocol
    
    init(movieInteractor : MovieInteractorProtocol,movieRouter : MovieRouterProtocol){
        
         self.interactor = movieInteractor
         self.router = movieRouter
    }
    
    func attachView(view :MovieViewProtocol ){
        self.movieView = view
    }
    
    func deAttach(){
        self.movieView = nil
    }
    
    func showMovies(_ completion: ([MovieViewModel])) {
        
    }
    
    func showMovieDetail(for viewModel: MovieViewModel) {
        
    }
    
    private func createMovieViewModels(from movies: [Movie]) -> [MovieViewModel] {
        return movies.map({ (movie) -> MovieViewModel in

            let index = movie.releaseDate.index(movie.releaseDate.startIndex, offsetBy: 5)
            let year = movie.releaseDate[..<index]
            
            let genreslist = movie.genres.compactMap { $0.name }
            
            return MovieViewModel( title: movie.title, year: String(year), genres: genreslist, overview: movie.overview )
        })
    }
    
}
