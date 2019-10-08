//
//  HomeMovieViewModel.swift
//  MovieScope
//
//  Created by Andrés Alexis Rivas Solorzano on 7/2/19.
//  Copyright © 2019 Andrés Alexis Rivas Solorzano. All rights reserved.
//

import Foundation


protocol HomeViewModelDelegate: class{
    func onSectionsUpdated(sectionList: [HomeSection])
    func onLoadingStatus(isLoading: Bool)
    func onErrorMsg(errorMsg: String)
}

class HomeViewModel{
    
    weak var coordinator: HomeMovieCoordinator?
    weak var delegate: HomeViewModelDelegate?
    
    var homeSections: [HomeSection] = []
    
    init(coordinator: HomeMovieCoordinator){
        self.coordinator = coordinator
    }
    
    func fetchData(){
        self.homeSections = []
        let supportedSectionTypes = HomeSectionType.allCases
        let startIndex = supportedSectionTypes.startIndex
        delegate?.onLoadingStatus(isLoading: true)
        recursiveRequest(typeArray: supportedSectionTypes, currentIndex: startIndex) {
            self.delegate?.onLoadingStatus(isLoading: false)
            self.delegate?.onSectionsUpdated(sectionList: self.homeSections)
        }

    }
    
    func recursiveRequest(typeArray: [HomeSectionType], currentIndex: Int, completion: @escaping()->()){
        
        guard currentIndex < typeArray.count else {
            completion()
            return
        }
        
        let type = typeArray[currentIndex]
        let networkRouter = self.getRouterForSection(type: type)
        let router = MovieListQueryRouter.init(networkRouter: networkRouter, categoryId: type.rawValue)
        
        fetchMovieCategorie(type: type, router: router) {
            let newIndex = currentIndex + 1
            self.recursiveRequest(typeArray: typeArray, currentIndex: newIndex, completion: completion)
        }
    }
    
    
    func fetchMovieCategorie(type: HomeSectionType, router: DataQueryRouter, completion: @escaping()->()){
     
        DataProvider.requestForData(router: router) { (result: Result<MovieListModel, Error>) in
            switch result{
            
            case .success(let movieList):
                movieList.categoryId = type.rawValue
                try? DataBaseManager.shared.coreStack.viewContext.save()
                
                if movieList.results.count > 0{
                    let newSection = HomeSection.init(type: type, movieList: movieList)
                    self.homeSections.append(newSection)
                }
                completion()
            case .failure(let error):
                print(error.localizedDescription)
                completion()
            }
        }
    }
    
    func getRouterForSection(type: HomeSectionType)->HomeRouter{
        switch type {
        case .popular:
            return .popular(page: 1)
        case .topRated:
            return .topRated(page: 1)
        case .upcoming:
            return .upcoming(page: 1)
        }
    }
    
    func searchMovie(query: String){
        
        let networkRouter = HomeRouter.search(query: query, page: 1)
        let router = SearchQueryRouter.init(networkRouter: networkRouter, catId: query)
        DataProvider.searchRequest(router: router) { result in
            switch result{
            case .success(let searchList):
                if searchList.results.count > 0{
                    self.coordinator?.showMovieList(router: networkRouter, movieList: searchList, controllerName: "Results", searchQuery: query, catId: nil)
                }else{
                    let errorMsg = "No results for:  \(query)."
                    self.delegate?.onErrorMsg(errorMsg: errorMsg)
                }
            case .failure(let error):
                print("Error \(error.localizedDescription)")
                self.delegate?.onErrorMsg(errorMsg: error.localizedDescription)
            }
        }
    }
    
    func showMovieList(sectionIndex: Int){
        
        let section = homeSections[sectionIndex]
        let movieList = section.movieList
        let controllerName = section.type.rawValue
        let router: HomeRouter
        switch section.type {
        case .popular:
            router = HomeRouter.popular(page: 1)
        case .topRated:
            router = .topRated(page: 1)
        case .upcoming:
            router = .upcoming(page: 1)
        }
        coordinator?.showMovieList(router: router, movieList: movieList, controllerName: controllerName, catId: section.type.rawValue)
    }
    
    func showDetail(forMovie: Int){
        self.coordinator?.showMovieDetail(id: forMovie)
    }
}
