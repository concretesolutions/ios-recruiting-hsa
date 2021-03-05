//
//  GenreInterface.swift
//  Movies
//
//  Created by Daniel Nunez on 05-03-21.
//

import Foundation

protocol GenreInterface {
    func fetchGenres(_ completion: @escaping ([Genre]?) -> (), errorCompletion: @escaping () -> ())
}
