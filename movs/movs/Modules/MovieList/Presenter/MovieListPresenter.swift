//
//  MovieListPresenter.swift
//  movs
//
//  Created by Andrés Alexis Rivas Solorzano on 10/6/19.
//  Copyright © 2019 Andrés Alexis Rivas Solorzano. All rights reserved.
//

import Foundation

protocol MovieListPresentationLogic: class {
    func presentMovieList(_ movieList: [MovieModel])
    func presentSearch(query: String)
}

class MovieListPresenter: MovieListPresentationLogic{
    
    private weak var view: MovieListDisplayLogic?
    
    init(view: MovieListDisplayLogic) {
        self.view = view
    }
    
    func presentMovieList(_ movieList: [MovieModel]) {
        DispatchQueue.main.async {
            let viewModel = MovieListViewModel(movieList: self.getMappedMovieList(movieList))
            self.view?.updateViewModel(viewModel: viewModel)
        }
    }
    
    func presentSearch(query: String) {
        view?.displaySearchResults(query: query)
    }
    
    private func getMappedMovieList(_ originalList: [MovieModel])->[MovieModel]{
        let mappedList = originalList.map { (movie) -> MovieModel in
            let mutableMovie = movie
            let searchQuery: CoreDataRequest = .findById(id: movie.id)
            mutableMovie.isFavorite = CoreDataProvider.shared.recordExist(LocalMovieModel.self, search: searchQuery.predicate)
            return mutableMovie
        }
        return mappedList
    }
}
