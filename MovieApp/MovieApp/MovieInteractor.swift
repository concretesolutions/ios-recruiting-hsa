//
//  MovieInteractor.swift
//  MovieApp
//
//  Created by Sebastian Diaz on 4/3/19.
//  Copyright © 2019 Accenture. All rights reserved.
//

import Foundation
protocol MovieInteractorProtocol {
    
    func getMovies(completion: (_ movies: [Movie]?)->Void)
    
}


class MovieInteractor : MovieInteractorProtocol {
    
//    var MovieAPiService : MovieAPIServiceProtocol
    
//    init(service : MovieAPiServiceProtocol){
//        self.MovieAPIService = service
//    }
    
    func getMovies(completion: (_ movies: [Movie]?)->Void) {
        //TODO - API SERVICE
        completion([])
    }
    
}
