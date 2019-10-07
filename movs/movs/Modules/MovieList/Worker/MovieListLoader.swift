//
//  MovieListLoader.swift
//  movs
//
//  Created by Andrés Alexis Rivas Solorzano on 10/6/19.
//  Copyright © 2019 Andrés Alexis Rivas Solorzano. All rights reserved.
//

import Foundation

protocol MovieListLoader{
    typealias Result = Swift.Result<MovieListModel, Error>
    func getMovieList(page: Int, completion: @escaping(Result)->Void)
    func searchMovie(searchQuery: String, page: Int, completion: @escaping (Result)->Void)
}
