//
//  FavoriteMoviesPresenter.swift
//  movs
//
//  Created by Andrés Alexis Rivas Solorzano on 10/6/19.
//  Copyright © 2019 Andrés Alexis Rivas Solorzano. All rights reserved.
//

import Foundation

protocol FavoriteMoviesPresentationLogic {
    func presentMovies(movieList: [LocalMovieModel])
    func presentFilters(for movieList: [LocalMovieModel], genres: [MovieGenreModel])
}

class FavoriteMoviesPresenter: FavoriteMoviesPresentationLogic{
    
    weak var view: FavoritesMoviesDisplayLogic?
    
    init(view: FavoritesMoviesDisplayLogic){
        self.view = view
    }
    
    func presentMovies(movieList: [LocalMovieModel]) {
        let viewModel = LocalMovieListViewModel(movieList: movieList)
        view?.updateViewModel(viewModel: viewModel)
    }
    
    func presentFilters(for movieList: [LocalMovieModel], genres: [MovieGenreModel]) {
        let years = movieList.map { (movie) -> FilterValue in
            let year = TimeHelper.getYearFromDate(dateString: movie.releaseDate) ?? ""
            return FilterValue(isSelected: false, name: year, coreDataId: movie.releaseDate)
        }
        
        let genres = genres.map { (genre) -> FilterValue in
            return FilterValue.init(isSelected: false, name: genre.name, coreDataId: String(genre.id))
        }
        
        let yearFilter = FilterModel.init(title: "Date", type: .date, values: years)
        let genresFilter = FilterModel.init(title: "Genre", type: .genre, values: genres)
        
        view?.displayFiltersView(filterList: [yearFilter, genresFilter])
    }
}
