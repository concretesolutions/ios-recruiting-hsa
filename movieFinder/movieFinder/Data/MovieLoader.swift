//
//  MovieLoader.swift
//  movieFinder
//
//  Created by Francisco Zuniga De Spirito on 28-09-22.
//

import Foundation

enum LoadMovieResult {
    case success([MovieItem])
    case error(Error)
}

protocol MovieLoader {
    func load(completion: @escaping (LoadMovieResult) -> Void)
}
