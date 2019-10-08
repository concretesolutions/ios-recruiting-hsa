//
//  DataProvider.swift
//  MovieScope
//
//  Created by Andrés Alexis Rivas Solorzano on 7/13/19.
//  Copyright © 2019 Andrés Alexis Rivas Solorzano. All rights reserved.
//

import Foundation
import CoreData

class DataProvider{
    
    //Generic Request
    class func requestForData<T: Codable & NSManagedObject>(router: DataQueryRouter, completion: @escaping (Result<T, Error>) -> ()) {
        
        let persistentContainer = DataBaseManager.shared.coreStack.viewContext
        
        guard NetworkServiceManager.availableConnection else {
            fetchCoreData(router: router, completion: completion)
            return
        }
        //Se espera a que el servicio responda, en caso de exito completa el request y avisa a coredata que elimine los resultados anteriores para que no se cargue la memoria del dispositivo
        NetworkServiceManager.request(context: persistentContainer,router: router.networkRouter,completion: { (result: Result<T, Error>) in
            
            switch result{
            case .success(let data):
                DataBaseManager.shared.deletePreviusResults(objectToConserve: data, search: router.queryPredicate)
                completion(.success(data))
            case .failure(let error):
                //En caso de que falle el request delega a coredata la entrega de resultas
                print(error.localizedDescription)
                fetchCoreData(router: router, completion: completion)
            }
                                        
                    
        })
    }
    
    class func searchRequest(router: SearchQueryRouter, completion: @escaping (Result<MovieListModel, Error>) -> ()){
        
        let persistentContainer = DataBaseManager.shared.coreStack.viewContext
        
        guard NetworkServiceManager.availableConnection else {
            let searchResults = fetchSearchMovieList(router: router)

            if searchResults.totalResults > 0 {
                completion(.success(searchResults))
            }else{
                completion(.failure(DBError.noExistingRecords))
            }
            return
        }
        //Se borran las busquedas anteriores
        DataBaseManager.shared.deleteResultsInQuery(MovieModel.self, search: router.queryPredicate)
        NetworkServiceManager.request(context: persistentContainer,
                                      router: router.networkRouter,
                                      completion: completion)
        
    }
    
    class func fetchMoviesByCategories(catRouter: SearchQueryRouter, movieTitle: String?) -> MovieListModel{
        
        let movieListsResults = DataBaseManager.shared.queryCoreData(MovieListModel.self, search: catRouter.queryPredicate)
        let movieResult: [MovieModel] = movieListsResults.flatMap{ $0.results.compactMap{ $0 } }
        if let queryTitle = movieTitle{
            let filterResults = movieResult.filter({$0.title.contains(queryTitle)})
            return newSearchRecord(movieList: filterResults)
        }
        return newSearchRecord(movieList: movieResult)
    }
    
    class func newSearchRecord(movieList: [MovieModel])->MovieListModel{
        let searchList = MovieListModel(context: DataBaseManager.shared.coreStack.viewContext)
        searchList.results = movieList
        searchList.page = 1
        searchList.categoryId = nil
        searchList.totalPages = 1
        searchList.totalResults = movieList.count
        return searchList
    }
    
    class func fetchSearchMovieList(router: SearchQueryRouter) -> MovieListModel{
        //Se busca en todas las peliculas aquellas que coincidan con la query de busqueda
        let results = DataBaseManager.shared.queryCoreData(MovieModel.self, search: router.queryPredicate)
        //Se crea una nueva lista de búsqueda
        return newSearchRecord(movieList: results)
    }
    
    
    class func fetchCoreData<T:NSManagedObject>(router: DataQueryRouter, completion: @escaping (Result<T, Error>) -> ()){
        
        let results = DataBaseManager.shared.queryCoreData(T.self, search: router.queryPredicate)
        if let result = results.first{
            completion(.success(result))
        }else{
            completion(.failure(DBError.noExistingRecords))
        }
        
    }
    
}

