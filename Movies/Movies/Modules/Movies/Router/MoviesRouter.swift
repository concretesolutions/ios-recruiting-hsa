//
//  MoviesRouter.swift
//  Movies
//
//  Created by Alfredo Luco on 05-02-21.
//

import Foundation

class MoviesRouter: PresenterToRouterMoviesProtocol {
    //MARK: - Debug memory release
    
    deinit {
        print("Movies Router Dealloc")
    }
}
