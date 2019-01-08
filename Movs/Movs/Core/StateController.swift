//
//  StateController.swift
//  Movs
//
//  Created by Miguel Duran on 1/7/19.
//  Copyright © 2019 Miguel Duran. All rights reserved.
//

import Foundation

protocol StatefulDelegate: class {
    func moviesChanged()
}

class StateController {
    var delegates = MulticastDelegate<StatefulDelegate>()
    var moviesDictionary = [Int: Movie]()
    
    func addMovie(_ movie: Movie) {
        moviesDictionary[movie.id] = movie
        delegates.invoke { $0.moviesChanged() }
    }
    
    func removeMovie(_ movie: Movie) {
        moviesDictionary.removeValue(forKey: movie.id)
        delegates.invoke { $0.moviesChanged() }
    }
    
    func getMovieById(_ id: Int) -> Movie? {
        return moviesDictionary[id]
    }
    
    func isMovieSaved(_ movie: Movie) -> Bool {
        if let _ = getMovieById(movie.id) {
            return true
        } else {
            return false
        }
    }
}
