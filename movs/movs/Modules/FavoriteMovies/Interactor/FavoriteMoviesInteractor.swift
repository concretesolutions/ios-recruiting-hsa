//
//  FavoriteMoviesInteractor.swift
//  movs
//
//  Created by Andrés Alexis Rivas Solorzano on 10/6/19.
//  Copyright © 2019 Andrés Alexis Rivas Solorzano. All rights reserved.
//

import Foundation

protocol FavoriteMoviesBusinessLogic {
    var hasActiveFilters: Bool { get }
    func getMovies()
    func removeFilters()
    func filterMovies(filterQuery: String)
    func unFavMovie(movieId: Int)
    func updateFilters(filterList: [FilterModel])
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
    
    private var moviesFilters: [FilterModel] = []{
        didSet{
            self.getMovies()
        }
    }
    
    var hasActiveFilters: Bool{
        return moviesFilters.contains(where: {$0.hasSelectedValue == true})
    }
    
    init(presenter: FavoriteMoviesPresentationLogic, loader: GenreListLoader) {
        self.presenter = presenter
        self.loader = loader
    }
    
    func getMovies() {
        let localMovies = CoreDataProvider.shared.queryCoreData(LocalMovieModel.self, search: nil)
        favoriteMovies = filterList(with: localMovies)
    }
    
    func filterMovies(filterQuery: String) {
        presenter.presentMovies(movieList: getFilteredList(with: filterQuery))
    }
    
    func removeFilters() {
        moviesFilters = []
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
    
    func updateFilters(filterList: [FilterModel]) {
        self.moviesFilters = filterList
    }
    
    private func getFilteredList(with query: String)->[LocalMovieModel]{
        guard query != "" else { return favoriteMovies }
        
        let filteredResults = favoriteMovies.filter{
            $0.title.lowercased().contains(query.lowercased())
        }
        
        return filteredResults
    }
    
    private func filterList(with originalList: [LocalMovieModel])->[LocalMovieModel]{
        var mutableList = originalList
       
        let genreFilters = moviesFilters.first(where: {$0.type == .genre})?.values.filter{$0.isSelected}.map{$0.coreDataId}.compactMap({Int($0)}) ?? []
        
        if genreFilters.count > 0{
            mutableList = originalList.filter { (movie) -> Bool in
                genreFilters.contains(where: {movie.genreIds.contains($0) })
            }
        }
        
        let yearFilters = moviesFilters.first(where: {$0.type == .date})?.values.filter{$0.isSelected}.map{$0.coreDataId} ?? []
        if yearFilters.count > 0 {
            mutableList = originalList.filter { (movie) -> Bool in
                yearFilters.contains(movie.releaseDate)
            }
        }
        
        return mutableList
    }
}
