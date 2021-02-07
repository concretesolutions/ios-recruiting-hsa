//
//  MovieDetailWorker.swift
//  Movies
//
//  Created by Alfredo Luco on 05-02-21.
//

import Foundation

class MovieDetailWorker {
    //MARK: - Memory debug
    
    deinit {
        print("movie detail worker dealloc")
    }
    
    //MARK: - Variables
    
    var genreRepo: CategoryStoreProtocol
    var movieRepo: MovieStoreProtocol
    
    //MARK: - Dependency Injection
    
    init(repo genre: CategoryStoreProtocol, repo movie: MovieStoreProtocol) {
        self.genreRepo = genre
        self.movieRepo = movie
    }
    
    //MARK: - Fetch Movie By ID
    
    func fetchMovie(by id: Int32, completion: @escaping FetchMovieCompletion) {
        self.movieRepo.fetchMovie(id, completion: completion)
    }
    
    //MARK: - Fetch Genres
    
    func fetchCategories(completion: @escaping FetchCategoriesCompletion) {
        self.genreRepo.fetchCategories(completion: completion)
    }
    
    //MARK: - Star Movie
    
    func starMovie(by id: Int32, completion: @escaping StarMovieCompletion) {
        self.movieRepo.starMovie(id, completion: completion)
    }
}
