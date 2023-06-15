//
//  ConsumirAPI.swift
//  proyMovieDB
//
//  Created by Tabata Céspedes Figueroa on 03-06-23.
//

import Foundation
import Alamofire

class ConsumirAPI {
    var rqApi = Requests()
    var resul:[DataResult] = []
    
    func obtenerListadoPeliculasPopulares() {
        
        AF.request(self.rqApi.obtenerListaPeliPopulares()).response {respuesta in
            guard let datos = respuesta.data else {
                return
            }
            
            do {
                let resultado = try JSONDecoder().decode(ResponsesPelisPopulares.self, from: datos)
                ResponsesPelisPopulares.shared.page = resultado.page
                ResponsesPelisPopulares.shared.results = resultado.results
                ResponsesPelisPopulares.shared.total_pages = resultado.total_pages
                ResponsesPelisPopulares.shared.total_results = resultado.total_results
            }
            catch let error {
                print("Error en obtenerListadoPeliculasPopulares \(error)")
            }
        }
    }
        
    func obtenerGeneros( ) {
        
        AF.request(self.rqApi.obtenerGenerosPeli()).response {respuesta in
            guard let datos = respuesta.data else {
                return
            }
            
            do {
                let resultado = try JSONDecoder().decode(ResponseGeneros.self, from: datos)
                ResponseGeneros.shared.genres = resultado.genres
            }
            catch let error {
                print("Error en obtenerGeneros \(error)")
            }
        }
    }
}
