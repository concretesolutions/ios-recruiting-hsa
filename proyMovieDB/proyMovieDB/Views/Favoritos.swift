//
//  Favoritos.swift
//  proyMovieDB
//
//  Created by Tabata Céspedes Figueroa on 08-06-23.
//

import Foundation

class Favoritos {
    var peliculaFav: [DetallePelicula]
    
    //MARK: Singleton
    static var shared = Favoritos()
    
    init(peliculaFav: [DetallePelicula] = []) {
        self.peliculaFav = peliculaFav
    }
}
