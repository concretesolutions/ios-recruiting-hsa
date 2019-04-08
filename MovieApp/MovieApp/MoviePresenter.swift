//
//  MoviePresenter.swift
//  MovieApp
//
//  Created by Sebastian Diaz on 4/3/19.
//  Copyright © 2019 Accenture. All rights reserved.
//

import Foundation

protocol MoviePresenterProtocol: class {
    func fetchMovies()
    func showMovieDetail(for viewModel: MovieViewModel)
}

protocol MovieInteractorOutput: class {
    func onFetchMovieSuccess(_ movies: [Movie]?, shouldAppend: Bool)
    func fetchMovieFailure(message: String)
    func fetchMovieTimeOut()
    func onFetchTimeOut()
}

class MoviePresenter {
    
    weak var movieView : MoviesViewProtocol?
    weak var movieInteractor : MovieInteractorProtocol?
    weak var genresInteractor : GenreInteractorProtocol?
    var router : MovieRouterProtocol
    var page : Int = 1
    
    init(movieInteractor : MovieInteractor,movieRouter : MovieRouterProtocol){
        self.movieInteractor = movieInteractor
        self.router = movieRouter
        movieInteractor.presenter = self
    }
    
    func attachView(view :MoviesViewProtocol ){
        self.movieView = view
    }
    
    func deAttach(){
        self.movieView = nil
    }
    
}

extension MoviePresenter : MoviePresenterProtocol {
    func matchMovieWithFavorite(viewModels: [MovieViewModel]) -> [MovieViewModel]{
        let localMovies = movieInteractor?.getLocalMovies()
        let ids = localMovies?.map{$0?.id}
        var mutable = viewModels
        
        for index in mutable.indices {
            mutable[index].favorite = (ids?.contains(viewModels[index].id))!
        }
        
        return mutable
    }

    func fetchMovies() {
        GenreInteractor.shared.onfetchGenres(success: {
            self.movieInteractor!.getAPIMovies()
        }, fail: {
            self.fetchMovieFailure(message: "Error en Generos")
        }) {
            self.onFetchTimeOut()
        }
    }
    
    func showMovieDetail(for viewModel: MovieViewModel) {
        router.showMovieDetail(for: viewModel)
    }
    
}


extension MoviePresenter : MovieInteractorOutput {
    func fetchMovieTimeOut() {
        movieView?.showTimeOut()
    }
    
    func onFetchMovieSuccess(_ movies: [Movie]?, shouldAppend: Bool) {
        let movieViewModel = createMovieViewModels(from: movies!)
        movieView?.showMovies(movies: movieViewModel,append:  shouldAppend)
    }
    
    func fetchMovieFailure(message: String) {
        movieView?.showErrorFetch()
    }
    
    func onFetchTimeOut() {
        
    }
}


