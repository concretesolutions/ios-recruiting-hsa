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
    
    func quitarFavoritoPorID(pID:Int){
        
        let posEliminar = obtenerIndiceFavorito(id:pID)
        favoriteMoviesArray.remove(at: posEliminar)
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
    
    func obtenerIndiceFavorito(id:Int) -> Int {
        
        var respuesta:Int = 0
        
        favoriteMoviesArray.forEach { dato in
            if dato.id == id {
                if let idX = favoriteMoviesArray.firstIndex(of: dato){
                    respuesta = idX
                }
            }
        }
        return respuesta
    }
    
}
