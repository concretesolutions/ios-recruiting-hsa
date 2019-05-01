//
//  PopularMoviesPresenter.swift
//  Concrete-Movies
//
//  Created by Audel Dugarte on 4/27/19.
//  Copyright © 2019 Audel Dugarte. All rights reserved.
//

import Foundation

class PopularMoviesPresenter{
    var popularMoviesView: PopularMoviesViewProtocol?
    
    private let fetchPopularMoviesUseCase: FetchPopularMoviesUseCase
    private let simpleMovieViewModelToModelMapper: Mapper<SimpleMovieViewModel, SimpleMovie>
    
    private let saveFavoriteMovieUseCase: SaveFavoriteMovieUseCase
    private let favoriteMovieViewModelToModelMapper: Mapper<FavoritedMovieViewModel, FavoritedMovie>
    
    init(fetchPopularMoviesUseCase: FetchPopularMoviesUseCase,
         simpleMovieViewModelToModelMapper: Mapper<SimpleMovieViewModel, SimpleMovie>,
         saveFavoriteMovieUseCase: SaveFavoriteMovieUseCase,
         favoriteMovieViewModelToModelMapper: Mapper<FavoritedMovieViewModel, FavoritedMovie>
        )
    {
        self.fetchPopularMoviesUseCase = fetchPopularMoviesUseCase
        self.simpleMovieViewModelToModelMapper = simpleMovieViewModelToModelMapper
        self.saveFavoriteMovieUseCase = saveFavoriteMovieUseCase
        self.favoriteMovieViewModelToModelMapper = favoriteMovieViewModelToModelMapper
    }
    
    func fetchMovies(){
        fetchPopularMoviesUseCase.execute { (moviesModels, error) in
            if let moviesModel = moviesModels{
                self.popularMoviesView?.show(movies: self.simpleMovieViewModelToModelMapper.reverseMap(values: moviesModel))
            }else if let error = error{
                self.popularMoviesView?.show(error: error)
            }
        }
    }
    
    func saveFavorite(movie: FavoritedMovieViewModel){
        saveFavoriteMovieUseCase.execute(favoriteMovie: favoriteMovieViewModelToModelMapper.map(value: movie))
    }
}
