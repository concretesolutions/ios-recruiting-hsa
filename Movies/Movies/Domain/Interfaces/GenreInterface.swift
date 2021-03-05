//
//  GenreInterface.swift
//  Movies
//
//  Created by Daniel Nunez on 05-03-21.
//

import Foundation

protocol GenreInterface {
    func fetchGenres(_ page: Int, _ completion: @escaping ([Movie]) -> (), errorCompletion: @escaping () -> ())
}
