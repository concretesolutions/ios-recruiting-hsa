//
//  APIManager.swift
//  TestProject
//
//  Created by Felipe S Vergara on 21-10-18.
//  Copyright © 2018 MyOwnCompany. All rights reserved.
//


import UIKit
import SwiftyJSON
import Alamofire

class APIManager: NSObject {
    static let shared = APIManager()
    let manager = Alamofire.SessionManager.default
    
    override init() {
        super.init()
        manager.session.configuration.timeoutIntervalForRequest = 3
    }
    
    //Return [Movie] array
    func getMovies(completition: @escaping ((_ responseObject: [Movie]?) -> Void), failure: @escaping ((_ error: Error) -> Void)) {
        manager.request(Config.moviesUrl(), method: .get, parameters: nil, encoding: JSONEncoding.default, headers: nil).responseJSON{ response in
            switch (response.result) {
            case .success(let value):
                let json = JSON(value)
                if json["results"].exists(){
                   let movies = try! JSONDecoder().decode([Movie].self, from: json["results"].rawData()) 
                   completition(movies)
                }else{
                   completition(nil)
                }
                
                break
            case .failure:
                if let error = response.error{
                    failure(error)
                }
                
                break
            }
            
        }
    }
    
    //Return [Genre] array
    func getGenres(completition: @escaping ((_ responseObject: [Genre]?) -> Void), failure: @escaping ((_ error: Error) -> Void)) {
        manager.request(Config.genresUrl(), method: .get, parameters: nil, encoding: JSONEncoding.default, headers: nil).responseJSON{ response in
            
            switch (response.result) {
            case .success(let value):
                let json = JSON(value)
                if json["genres"].exists(){
                    let genres = try! JSONDecoder().decode([Genre].self, from: json["genres"].rawData())
                    completition(genres)
                }else{
                    completition(nil)
                }
                
                break
            case .failure:
                if let error = response.error{
                    failure(error)
                }
                
                break
            }
            
        }
    }
}

