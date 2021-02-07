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
    
    //Fetch Movie
    
    func fetchMovie(_ id: Int32, completion: @escaping FetchMovieCompletion)
    
    //Star Movie
    
    func starMovie(_ id: Int32, completion: @escaping StarMovieCompletion)
    
    //Fetch starred movies
    
    func fetchStarredMovies(_ completion: @escaping FetchStarredMoviesCompletion)
    
    //Fetch movie years
    
    func fetchMovieYears(_ completion: @escaping FetchMovieYearsCompletion)
}


//MARK: - Typealias

typealias FetchPopularMoviesCompletion = (FetchPopularMoviesResult) -> Void
typealias SearchPopularMoviesCompletion = (SearchPopularMoviesResult) -> Void
typealias FetchMovieCompletion = (FetchMovieResult) -> Void
typealias StarMovieCompletion = (StarMovieResult) -> Void
typealias FetchStarredMoviesCompletion = (FetchStarredMoviesResult) -> Void
typealias FetchMovieYearsCompletion = (FetchMovieYearsResult) -> Void

//MARK: - Use Cases

enum FetchPopularMoviesResult {
    case success(_ movies: [Movie])
    case failure(_ error: Error)
}

enum FetchMovieResult {
    case success(_ movie: Movie)
    case failure(_ error: Error)
}

enum SearchPopularMoviesResult {
    case success(_ movies: [Movie])
    case failure(_ error: Error)
}

enum StarMovieResult {
    case success(_ resolve: Bool)
    case failure(_ error: Error)
}

enum FetchStarredMoviesResult {
    case success(_ movies: [Movie])
    case failure(_ error: Error)
}

enum FetchMovieYearsResult {
    case success(_ years: [String])
    case failure(_ error: Error)
}
