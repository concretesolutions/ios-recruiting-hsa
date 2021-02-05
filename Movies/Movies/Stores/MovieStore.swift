//
//  MovieStore.swift
//  Movies
//
//  Created by Alfredo Luco on 05-02-21.
//

import Foundation

//MARK: - Movie Store Definition

protocol MovieStoreProtocol: class {
    
    //Fetch Popular movies use case
    
    func fetchPopularMovies(completion: @escaping FetchPopularMoviesCompletion)
    
}


//MARK: - Typealias

typealias FetchPopularMoviesCompletion = (FetchPopularMoviesResult) -> Void

//MARK: - Use Cases

enum FetchPopularMoviesResult {
    case success(_ movies: [Movie])
    case failure(_ error: Error)
}
