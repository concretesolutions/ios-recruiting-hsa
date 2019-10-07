//
//  MovieListWireframe.swift
//  movs
//
//  Created by Andrés Alexis Rivas Solorzano on 10/6/19.
//  Copyright © 2019 Andrés Alexis Rivas Solorzano. All rights reserved.
//

import Foundation

protocol MovieListWireframe {
    func routeToDetail(from movieId: Int, withTitle: String)
    func routeToSearch(withQuery: String)
}

extension MovieListWireframe where Self: Wireframe{
    
    func routeToDetail(from movieId: Int, withTitle: String){
        let detailRouter = MovieDetailRouter(navigation: navigation, movieId: movieId, movieTitle: withTitle)
        navigation.pushViewController(detailRouter.detailController, animated: true)
    }
    
    func routeToSearch(withQuery: String){
        let newMovieList = MovieListViewController(router: self, searchQuery: withQuery)
        navigation.pushViewController(newMovieList, animated: true)
    }
    
}

extension Wireframe: MovieListWireframe{}
