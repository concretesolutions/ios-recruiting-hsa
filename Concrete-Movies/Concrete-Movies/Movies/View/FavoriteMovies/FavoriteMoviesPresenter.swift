//
//  FavoriteMoviesPresenter.swift
//  Concrete-Movies
//
//  Created by Audel Dugarte on 5/1/19.
//  Copyright © 2019 Audel Dugarte. All rights reserved.
//

import Foundation

class FavoriteMoviesPresenter {
    var favoriteMoviesView: FavoriteMoviesViewProtocol?
    
    private let fetchFavoritedMoviesUseCase: FetchFavoritedMoviesUseCase
    private let favoriteMovieViewModelToModelMapper: Mapper<FavoritedMovieViewModel, FavoritedMovie>
    
    init(fetchFavoritedMoviesUseCase: FetchFavoritedMoviesUseCase,
         favoriteMovieViewModelToModelMapper: Mapper<FavoritedMovieViewModel, FavoritedMovie>
        )
    {
        self.fetchFavoritedMoviesUseCase = fetchFavoritedMoviesUseCase
        self.favoriteMovieViewModelToModelMapper = favoriteMovieViewModelToModelMapper
    }
    
    func fetchFavoriteMovies(){
        fetchFavoritedMoviesUseCase.execute { (movies, error) in
            if let movies = movies{
                self.favoriteMoviesView?.show(movies: self.favoriteMovieViewModelToModelMapper.reverseMap(values: movies))
            }else{
                self.favoriteMoviesView?.show(error: error!)
            }
        }
    }
}
