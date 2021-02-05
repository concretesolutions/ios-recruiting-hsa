//
//  MoviesWorker.swift
//  Movies
//
//  Created by Alfredo Luco on 05-02-21.
//

import Foundation

class MoviesWorker {
    
    //MARK: - Memory debug
    
    deinit {
        print("Movies worker dealloc")
    }
    
    //MARK: - Variables
    
    var repo: MovieStoreProtocol
    
    //MARK: - Dependency Injection
    
    init(_ repo: MovieStoreProtocol) {
        self.repo = repo
    }
    
    //MARK: - fetch movies
    
    func fetchMovies(_ completion: @escaping FetchPopularMoviesCompletion) {
        self.repo.fetchPopularMovies(completion: completion)
    }
    
    //MARK: - search movies
    
    func searchMovies(text: String,_ completion: @escaping SearchPopularMoviesCompletion) {
        self.repo.searchPopularMovies(text, completion: completion)
    }
    
}
