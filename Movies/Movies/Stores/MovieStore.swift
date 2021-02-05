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
    
    //Search Popular movies use case
    
    func searchPopularMovies(_ text: String, completion: @escaping SearchPopularMoviesCompletion)
    
}


//MARK: - Typealias

typealias FetchPopularMoviesCompletion = (FetchPopularMoviesResult) -> Void
typealias SearchPopularMoviesCompletion = (SearchPopularMoviesResult) -> Void

//MARK: - Use Cases

enum FetchPopularMoviesResult {
    case success(_ movies: [Movie])
    case failure(_ error: Error)
}

enum SearchPopularMoviesResult {
    case success(_ movies: [Movie])
    case failure(_ error: Error)
}
