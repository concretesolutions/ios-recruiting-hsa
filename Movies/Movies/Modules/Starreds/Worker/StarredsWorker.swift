//
//  StarredsWorker.swift
//  Movies
//
//  Created by Alfredo Luco on 07-02-21.
//

import Foundation

class StarredsWorker {
    
    //MARK: - Memory debug
    
    deinit {
        print("starreds worker dealloc")
    }
    
    //MARK: - Variables
    
    var repo: MovieStoreProtocol
    
    //MARK: - Dependency Injection
    
    init(_ repo: MovieStoreProtocol) {
        self.repo = repo
    }
    
    //MARK: - Fetch Starreds Movies
    
    func fetchStarredsMovies(_ completion: @escaping FetchStarredMoviesCompletion) {
        self.repo.fetchStarredMovies(completion)
    }
    
    //MARK: - Unstar movie
    
    func unstarMovie(_ id: Int32, _ completion: @escaping StarMovieCompletion) {
        self.repo.starMovie(id, completion: completion)
    }
    
    //MARK: - Filter Movies
    
    func filterMovies(_ filters: [Filter<String>], _ completion: @escaping FetchPopularMoviesCompletion) {
        self.repo.fetchFilteredMovies(filters, completion)
    }
    
}
