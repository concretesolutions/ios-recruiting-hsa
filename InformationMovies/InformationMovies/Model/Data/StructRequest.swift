//
//  StructRequest.swift
//  InformationMovies
//
//  Created by Cristian Bahamondes on 25-06-22.
//

import Foundation

class StructRequest: ProtocolStructRequest {
    
    //MARK: Singleton
    static var shared = StructRequest()
    
    //MARK: Properties
    var inicioLink:String
    var finalLink:String
    var respuestaURL:String
    var apiKEY:String
    var cadenaInicialImagen:String
    
    //MARK: Init
    init
    (inicioLink:String = String(), apiKEY:String = String(), finalLink:String = String(), respuestaURL:String = String(), cadenaInicialImagen:String = String()){
        self.inicioLink = inicioLink
        self.finalLink = finalLink
        self.apiKEY = apiKEY
        self.respuestaURL = respuestaURL
        self.cadenaInicialImagen = cadenaInicialImagen
    }
    
    //MARK: Funciones
    func getURLpopularMovies() -> String {
        
        inicioLink = "https://api.themoviedb.org/3/movie/popular?api_key="
        finalLink = "&language=en-US&page=1"
        apiKEY = "e3e26362b1bc18ac0906d6e19b28ad0e"
        respuestaURL = inicioLink + apiKEY + finalLink
        
        return respuestaURL
    }
    
    func getURLCategories() -> String {
        
        inicioLink = "https://api.themoviedb.org/3/genre/movie/list?api_key="
        finalLink = "&language=en-US"
        apiKEY = "e3e26362b1bc18ac0906d6e19b28ad0e"
        respuestaURL = inicioLink + apiKEY + finalLink
        
        return respuestaURL
    }
    
    func getURLimage(cadenaFinalImagen:String) -> String {
        
        cadenaInicialImagen = "http://image.tmdb.org/t/p/w500"
        return cadenaInicialImagen + cadenaFinalImagen
    }
    
}
