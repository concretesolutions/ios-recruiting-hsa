//
//  ConsumeAPI.swift
//  InformationMovies
//
//  Created by Cristian Bahamondes on 25-06-22.
//

import Foundation
import Alamofire

class ConsumeAPI:ProtocolConsumirAPI {
    
    //MARK: Singleton
    static var shared = ConsumeAPI()
    
    //MARK: Funciones
    func getPopularMovies()
    {
        let URL = StructRequest.shared.getURLpopularMovies()
        
        AF.request(URL).response { respuesta in
            
            guard let data = respuesta.data else {
                print("SIN DATA")
                return
            }

            do {
                let resultAUX = try JSONDecoder().decode(ResponsePopularMovies.self, from: data)
                
                ResponsePopularMovies.shared.page = resultAUX.page
                ResponsePopularMovies.shared.results = resultAUX.results
                ResponsePopularMovies.shared.total_results = resultAUX.total_results
                ResponsePopularMovies.shared.total_pages = resultAUX.total_pages
            }
            
            catch let error {
                print("ERROR: \(error)")
            }
        }
    }
    
    func getCategorias()
    {
        let URL = StructRequest.shared.getURLCategories()
        
        AF.request(URL).response { respuesta in
            
            guard let data = respuesta.data else {
                print("SIN DATA")
                return
            }

            do {
                let resultAUX = try JSONDecoder().decode(ResponseCategories.self, from: data)
                
                ResponseCategories.shared.genres = resultAUX.genres
            }
            
            catch let error {
                print("ERROR: \(error)")
            }
        }
    }
}
