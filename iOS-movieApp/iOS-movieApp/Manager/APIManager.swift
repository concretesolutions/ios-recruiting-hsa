//
//  APIManager.swift
//  iOS-movieApp
//
//  Created by alvaro.concha on 01-07-22.
//

import Foundation
import Alamofire

class APIManager{
    
    private let urlApi: String
    private let manager : Session
    
    init(){
        self.urlApi = Endpoints.domain
        
        let configuration : URLSessionConfiguration = {
            let config = URLSessionConfiguration.default
            
            return config
        }()
        
        self.manager = Session(configuration : configuration)
    }
    
    
    func getPopularMovies(completionHandler : @escaping([MovieResult]?) -> Void){
        
        let url = Endpoints.popularMovies
        requestPopularMovies(urlApi: url, completionHandler : completionHandler)
        
    }
    
    func getGenres(completionHandler : @escaping(getGenre?) -> Void){
        
        let url = Endpoints.genres
        requestGenre(urlApi: url, completionHandler : completionHandler)
        
    }
    

    
    
    private func requestPopularMovies<collectionMovies:Codable>(urlApi : String, completionHandler : @escaping(collectionMovies?) -> Void){
        
        AF.request(urlApi).response { response in
            if response.error != nil {
                print("se encontró un error")
                return
            }
            guard let data = response.data else {
                print("sin datos")
                return
            }
            do {
                let popularMovies = try JSONDecoder().decode( getPopularResponse.self, from: data )
                
                completionHandler(popularMovies.results as? collectionMovies)
            } catch let error {
                //Aqui cuando hay un error en la API
                print("Aqui cuando hay un error en la API_:", error)
            }
        }
        
    }
    
    private func requestGenre<collectionGenre:Codable>(urlApi : String, completionHandler : @escaping(collectionGenre?) -> Void){
        
        AF.request(urlApi).response { response in
            if response.error != nil {
                print("se encontró un error")
                return
            }
            guard let data = response.data else {
                print("sin datos")
                return
            }
            do {
                let genres = try JSONDecoder().decode( getGenre.self, from: data )
                
                
                completionHandler(genres as? collectionGenre)
            } catch let error {
                //Aqui cuando hay un error en la API
                print("Aqui cuando hay un error en la API_:", error)
            }
        }
        
    }
}
