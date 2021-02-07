//
//  FilterContentWorker.swift
//  Movies
//
//  Created by Alfredo Luco on 07-02-21.
//

import Foundation

class FilterContentWorker {
    
    //MARK: - Memory debug
    
    deinit {
        print("filter content worker dealloc")
    }
    
    //MARK: - Variables
    
    var movieRepo: MovieStoreProtocol
    var genreRepo: CategoryStoreProtocol
    
    //MARK: - Dependency Injection
    
    init(repo genre: CategoryStoreProtocol, repo movie: MovieStoreProtocol) {
        self.movieRepo = movie
        self.genreRepo = genre
    }
    
    //MARK: - Fetch Genres
    
    func fetchGenres(_ completion: @escaping FetchCategoriesCompletion) {
        self.genreRepo.fetchCategories(completion: completion)
    }
    
    //MARK: - Fetch Movie Years
    func fetchYears(_ completion: @escaping FetchMovieYearsCompletion) {
        self.movieRepo.fetchMovieYears(completion)
    }
    
}
