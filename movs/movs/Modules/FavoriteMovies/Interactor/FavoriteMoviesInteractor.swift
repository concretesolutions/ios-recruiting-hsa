//
//  FavoriteMoviesInteractor.swift
//  movs
//
//  Created by Andrés Alexis Rivas Solorzano on 10/6/19.
//  Copyright © 2019 Andrés Alexis Rivas Solorzano. All rights reserved.
//

import Foundation

protocol FavoriteMoviesBusinessLogic {
    func getMovies()
    func filterMovies(filterQuery: String)
    func unFavMovie(movieId: Int)
    func prepareFilters()
}

class FavoriteMoviesInteractor: FavoriteMoviesBusinessLogic{
    
    let presenter: FavoriteMoviesPresentationLogic
    private let loader: GenreListLoader
    private var favoriteMovies: [LocalMovieModel] = []{
        didSet{
            self.presenter.presentMovies(movieList: favoriteMovies)
        }
    }
    
    init(presenter: FavoriteMoviesPresentationLogic, loader: GenreListLoader) {
        self.presenter = presenter
        self.loader = loader
    }
    
    func getMovies() {
        favoriteMovies = CoreDataProvider.shared.queryCoreData(LocalMovieModel.self, search: nil)
    }
    
    func filterMovies(filterQuery: String) {
        presenter.presentMovies(movieList: getFilteredList(with: filterQuery))
    }
    
    func unFavMovie(movieId: Int) {
        guard favoriteMovies.contains(where: {$0.id == movieId }) else { return }
        let coreDataQuery: CoreDataRequest = .findById(id: movieId)
        if CoreDataProvider.shared.recordExist(LocalMovieModel.self, search: coreDataQuery.predicate){
            CoreDataProvider.shared.deleteResultsInQuery(LocalMovieModel.self, search: coreDataQuery.predicate)
            CoreDataProvider.shared.save()
        }
        getMovies()
    }
    
    func prepareFilters() {
        loader.getGenreList { (result) in
            switch result{
            case .success(let genres):
                self.presenter.presentFilters(for: self.favoriteMovies, genres: genres)
            case .failure(let error):
                print(error)
            }
        }
    }
    
    private func getFilteredList(with query: String)->[LocalMovieModel]{
        guard query != "" else { return favoriteMovies }
        
        let filteredResults = favoriteMovies.filter{
            $0.title.lowercased().contains(query.lowercased())
        }
        
        return filteredResults
    }
}
