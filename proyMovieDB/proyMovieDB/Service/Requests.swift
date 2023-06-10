//
//  Requests.swift
//  proyMovieDB
//
//  Created by Tabata Céspedes Figueroa on 03-06-23.
//

import Foundation

class Requests {
    var protocoloDominioSc:String
    var slug:String
    var apiKey:String
    var lenguaje:String
    var url:String
    
    init(protocoloDominioSc: String = String(), slug: String = String(), apiKey: String = String(), lenguaje: String = String(), url: String = String()) {
        self.protocoloDominioSc = protocoloDominioSc
        self.slug = slug
        self.apiKey = apiKey
        self.lenguaje = lenguaje
        self.url = url
    }
    
    func obtenerListaPeliPopulares() -> String {
        protocoloDominioSc = "https://api.themoviedb.org/3"
        slug = "/movie/popular"
        apiKey = "?api_key=e3e26362b1bc18ac0906d6e19b28ad0e"
        lenguaje = "&language=es-MX&page=1"
        url = protocoloDominioSc + slug + apiKey + lenguaje
        return url
    }
    
    func obtenerGenerosPeli() -> String {
        protocoloDominioSc = "https://api.themoviedb.org/3"
        slug = "/genre/movie/list"
        apiKey = "?api_key=e3e26362b1bc18ac0906d6e19b28ad0e"
        lenguaje = "&language=es-MX"
        url = protocoloDominioSc + slug + apiKey + lenguaje
        return url
    }
    
    func obtenerImagenPeli(urlImagen: String) -> String {
        protocoloDominioSc = "http://image.tmdb.org/t"
        slug = "/p/w500"
        return protocoloDominioSc + slug + urlImagen
    }
}
