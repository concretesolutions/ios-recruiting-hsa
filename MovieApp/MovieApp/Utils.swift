
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
        let favorite = movie.favorite
        
        var result : [Genre] = []
        for idGenre in movie.genres {
            if let genre = GenreInteractor.shared.findAGenre(id:idGenre.value){
                 result.append(genre)
            }
        }
        
        return MovieViewModel(id:movie.id, title: movie.title, year: String(year), genres:result, overview: movie.overview, imagePath: imagePath, favorite: favorite)
    })
}

extension Sequence where Iterator.Element: Hashable {
    func unique() -> [Iterator.Element] {
        var seen: [Iterator.Element: Bool] = [:]
        return self.filter { seen.updateValue(true, forKey: $0) == nil }
    }
}

extension UIView {
    class func fromNib<T: UIView>() -> T {
        return Bundle.main.loadNibNamed(String(describing: T.self), owner: nil, options: nil)![0] as! T
    }
}

