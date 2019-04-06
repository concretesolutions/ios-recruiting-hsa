
//
//  Utils.swift
//  MovieApp
//
//  Created by Sebastian Diaz on 4/6/19.
//  Copyright © 2019 Accenture. All rights reserved.
//

import Foundation
import RealmSwift


extension Results {
    func toArray<T>(ofType: T.Type) -> [T] {
        var array = [T]()
        for i in 0 ..< count {
            if let result = self[i] as? T {
                array.append(result)
            }
        }
        
        return array
    }
}

func createMovieViewModels(from movies: [Movie]) -> [MovieViewModel] {
    return movies.map({ (movie) -> MovieViewModel in
        
        let index = movie.releaseDate.index(movie.releaseDate.startIndex, offsetBy: 4)
        let year = movie.releaseDate[..<index]
        let imagePath = movie.imagePath
        
        
        return MovieViewModel(id:movie.id, title: movie.title, year: String(year), genres: [Genre(id: 1, name: "DESCONOCIDO")], overview: movie.overview, imagePath: imagePath )
    })
}
