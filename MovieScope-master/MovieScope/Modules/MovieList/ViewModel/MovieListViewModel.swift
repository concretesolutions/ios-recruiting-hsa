//
//  MovieListViewModel.swift
//  MovieScope
//
//  Created by Andrés Alexis Rivas Solorzano on 7/9/19.
//  Copyright © 2019 Andrés Alexis Rivas Solorzano. All rights reserved.
//

import Foundation


protocol MovieListViewModelDelegate: class {
    func onDataUpdate(movies: [MovieModel])
    func onLoadingStatus(isLoading: Bool)
    func onErrorMsg(errorMsg: String)
}

class MovieListViewModel{

    var movieList: [MovieModel]
    var router: HomeRouter
    var searchQuery: String
    var totalPages: Int
    var canLoadMore: Bool
    var categoryId: String?
    
    weak var delegate: MovieListViewModelDelegate?
    weak var coordinator: MovieListCoordinator?
    
    //Cada vez que se actualiza la lista de resultados filtrados se actualiza la vista
    var filteredList: [MovieModel] = []{
        didSet{
            delegate?.onDataUpdate(movies: filteredList)
        }
    }
    
    //Cuando el valor currentPage cambia, si es mayor que su antiguo valor dispara el servicio que carga una nueva pagina de peliculas
    var currentPage: Int{
        didSet{
            if currentPage > oldValue {
                fetchData()
            }
        }
    }
    
    init(initialPage: Int, router: HomeRouter, movieList: MovieListModel, searchQuery: String, catId: String?){
        self.currentPage = initialPage
        self.router = router
        self.movieList = movieList.results
        self.searchQuery = searchQuery
        self.categoryId = catId
        self.totalPages = movieList.totalPages
        canLoadMore = currentPage < totalPages
    }
    
    func fetchData(){
        
        // Se valida que no se cargue una data inexistente. Por ej: Se evita que la lista cargue si tiene un limite de 5 paginas y se intenta cargar la 6
        guard currentPage <= totalPages else {
            canLoadMore = false
            return
        }
        
        router = updateRouter(newPage: currentPage)
        
        let categoryId = self.categoryId ?? ""
        let requestRouter = MovieListQueryRouter.init(networkRouter: router, categoryId: categoryId)
        DataProvider.requestForData(router: requestRouter) { (result: Result<MovieListModel, Error>) in
            switch result{
            case .success(let movieListResponse):
                if let catId = self.categoryId{
                    movieListResponse.categoryId = catId
                    try? DataBaseManager.shared.coreStack.viewContext.save()
                }
                self.movieList.append(contentsOf: movieListResponse.results)
                self.delegate?.onDataUpdate(movies: movieListResponse.results)
            case .failure(let error):
                self.delegate?.onErrorMsg(errorMsg: error.localizedDescription)
            }
        
        }
    }
    
    func searchOnlineData(query: String){
        let categoryId = self.categoryId ?? ""
        let networkRouter = HomeRouter.search(query: query, page: 1)
        let router = SearchQueryRouter.init(networkRouter: networkRouter, catId: categoryId)
        delegate?.onLoadingStatus(isLoading: true)
        DataProvider.searchRequest(router: router) { result in
            self.delegate?.onLoadingStatus(isLoading: false)
            switch result{
            case .success(let searchList):
                self.displaySearchResult(searchResultList: searchList, router: networkRouter, searchQuery: query)
            case .failure(let error):
                print("Error \(error.localizedDescription)")
                self.delegate?.onErrorMsg(errorMsg: error.localizedDescription)
            }
        }
    }
    
    func searchOffLineData(movieName: String){
        
        let categoryId = self.categoryId ?? ""
        let requestRouter = SearchQueryRouter.init(networkRouter: self.router, catId: categoryId)
        let movieResults = DataProvider.fetchMoviesByCategories(catRouter: requestRouter, movieTitle: movieName)
        
        let networkRouter = HomeRouter.search(query: movieName, page: 1)
        displaySearchResult(searchResultList: movieResults, router: networkRouter, searchQuery: movieName)
    }
    
    func filterMovies(_ queryText: String) {
        guard queryText != "" else{
            filteredList = movieList
            return
        }
        
        filteredList = movieList.filter({ (movie) -> Bool in
            return movie.title.lowercased().contains(queryText.lowercased())
        })
    }
    
    
    func showDetailMovie(atIndex: Int, filteringResults: Bool){
        let movieId = filteringResults ? filteredList[atIndex].id : movieList[atIndex].id
        coordinator?.showMovieDetail(id: movieId)
    }
    
    
    /*Metodos privados*/
    
    //Notifica al coordinator en caso de que 
    private func displaySearchResult(searchResultList: MovieListModel, router: HomeRouter, searchQuery: String){
        if searchResultList.results.count > 0{
            let controllerName = categoryId ?? "Results"
            self.coordinator?.showMovieList(router: router, movieList: searchResultList, controllerName: controllerName, searchQuery: searchQuery, catId: self.categoryId)
        }else{
            let errorMsg = "No results for:  \(searchQuery)."
            self.delegate?.onErrorMsg(errorMsg: errorMsg)
        }
    }
    
    private func updateRouter(newPage: Int)->HomeRouter{
        switch router {
        case .popular(_):
            return .popular(page: newPage)
        case .topRated(_):
            return .topRated(page: newPage)
        case .upcoming(_):
            return .upcoming(page: newPage)
        case .search(_):
            return .search(query: searchQuery, page: newPage)
        }
    }
    
}
