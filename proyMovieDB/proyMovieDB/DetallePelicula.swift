//
//  DetallePelicula.swift
//  proyMovieDB
//
//  Created by Tabata Céspedes Figueroa on 07-06-23.
//

import Foundation

struct DetallePelicula: Equatable {
    var genero:[String]
    var anio:String
    var titulo:String
    var descripcion:String
    var id:Int
    var urlImagenAmpliada:String
    var urlImagenPoster:String
    
    init(genero: [String] = [], urlimagen: String = "", anio: String = "", titulo: String = "", descripcion: String = "", id: Int = 0, urlImagenAmpliada: String = "", urlImagenPoster: String = "") {
        self.genero = genero
        self.anio = anio
        self.titulo = titulo
        self.descripcion = descripcion
        self.id = id
        self.urlImagenAmpliada = urlImagenAmpliada
        self.urlImagenPoster = urlImagenPoster
    }
}


