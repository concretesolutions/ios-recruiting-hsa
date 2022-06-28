//
//  FavoriteMovies.swift
//  InformationMovies
//
//  Created by Cristian Bahamondes on 27-06-22.
//

import Foundation

class FavoriteMovies {
    
    //MARK: Singleton
    static var shared = FavoriteMovies()
    
    //MARK: Atributes
    var favoriteMoviesArray:[DataResult]
    
    //MARK: Init
    init(favoriteMoviesArray:[DataResult] = []){
        self.favoriteMoviesArray = favoriteMoviesArray
    }
    
    //MARK: Funciones
    func agregarFavorito(datos:DataResult) {
        
        favoriteMoviesArray.append(datos)
    }
    
    func quitarFavorito(posIndex:Int) {
        
        favoriteMoviesArray.remove(at: posIndex)
    }
    
    func validarFavorito(idValidar:Int) -> Bool {
        
        var respuesta:Bool = false
        
        favoriteMoviesArray.forEach { favMovie in
            if favMovie.id == idValidar {
                respuesta = true
            }
        }
        return respuesta
    }
    
}
