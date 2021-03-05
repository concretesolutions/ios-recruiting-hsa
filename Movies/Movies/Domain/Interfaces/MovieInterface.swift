//
//  MovieInterface.swift
//  Movies
//
//  Created by Daniel Nunez on 04-03-21.
//

import Foundation

protocol MovieInterface {
    func fetchMovies(_ page: Int, _ completion: @escaping ([Movie]) -> Void, errorCompletion: @escaping () -> Void)
}
