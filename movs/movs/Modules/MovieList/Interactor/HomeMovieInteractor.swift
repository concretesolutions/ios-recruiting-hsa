//
//  HomeMovieInteractor.swift
//  movs
//
//  Created by Andrés Alexis Rivas Solorzano on 10/2/19.
//  Copyright © 2019 Andrés Alexis Rivas Solorzano. All rights reserved.
//

import Foundation

protocol MovieListBusinessLogic {
    func fetchMoreMovies()
    func searchMovie(searchQuery: String)
    func filterMovies(filterQuery: String)
    func changeFavoriteStatus(of movieId: Int)
}

class MovieListInteractor: MovieListBusinessLogic{
    
    private var presenter: MovieListPresentationLogic
    private var loader: MovieListLoader
    private var totalPages = 1
    private var currentPage = 0
    private let initialSearch: String?
    private var movieResults: [MovieModel] = []{
        didSet{
            self.presenter.presentMovieList(movieResults)
        }
    }
    private var canLoadMore: Bool{
        return currentPage < totalPages
    }
    
    init(loader: MovieListLoader, presenter: MovieListPresentationLogic, searchQuery: String? = nil) {
        self.loader = loader
        self.initialSearch = searchQuery
        self.presenter = presenter
    }
    
    func fetchMoreMovies() {
        guard canLoadMore else { return }
        let newPage = currentPage + 1
        if let searchQuery = initialSearch{
            loader.searchMovie(searchQuery: searchQuery, page: newPage, completion: updateResults())
        }else{
            loader.getMovieList(page: newPage, completion: updateResults())
        }
    }
    
    func searchMovie(searchQuery: String) {
        loader.searchMovie(searchQuery: searchQuery, page: 1, completion: searchCompleted(searchQuery))
    }
    
    func filterMovies(filterQuery: String) {
        presenter.presentMovieList(getFilteredList(with: filterQuery))
    }
    
    func changeFavoriteStatus(of movieId: Int) {
        guard let movieForChange = movieResults.first(where: {$0.id == movieId}) else { return }
        let coreDataQuery: CoreDataRequest = .findById(id: movieId)
        if CoreDataProvider.shared.recordExist(LocalMovieModel.self, search: coreDataQuery.predicate){
            CoreDataProvider.shared.deleteResultsInQuery(LocalMovieModel.self, search: coreDataQuery.predicate)
        }else if let newRecord = CoreDataProvider.shared.addRecord(LocalMovieModel.self){
            newRecord.saveMovie(movie: movieForChange)
            CoreDataProvider.shared.save()
        }
        presenter.presentMovieList(movieResults)
    }
    
    private func searchCompleted(_ searchQuery: String)->(RemoteMovieListLoader.Result)->Void{
        let task: (RemoteMovieListLoader.Result) -> Void = { result in
            switch result {
            case .success(_):
                self.presenter.presentSearch(query: searchQuery)
            case .failure(let error):
                print(error)
            }
        }
        return task
    }
    
    private func updateResults()-> (RemoteMovieListLoader.Result)->Void{
        let task: (RemoteMovieListLoader.Result) -> Void = { result in
            switch result{
            case .success(let movies):
                self.updateMovieData(with: movies)
            case .failure(let error):
                print(error)
            }
        }
        return task
    }
    
    private func updateMovieData(with movieList: MovieListModel){
        self.currentPage = movieList.page
        self.totalPages = movieList.totalPages
        self.movieResults.append(contentsOf: movieList.results)
    }
    
    private func getFilteredList(with query: String)->[MovieModel]{
        guard query != "" else { return movieResults }
        
        let filteredResults = movieResults.filter{
            $0.title.lowercased().contains(query.lowercased())
        }
        
        return filteredResults
    }
    
    
}
