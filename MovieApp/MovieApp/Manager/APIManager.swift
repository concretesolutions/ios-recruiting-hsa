//
//  APIManager.swift
//  MovieApp
//
//  Created by luis.a.rosas.arce on 24/01/19.
//  Copyright © 2019 luis.a.rosas.arce. All rights reserved.
//

import UIKit
import SwiftyJSON

class APIManager: NSObject {
    let baseURL = "https://api.themoviedb.org/3";
    let apiKey = "?api_key=3042e8bdbaa8e107eb16f23ff5195097"
    
    
    static let sharedInstance = APIManager()
    static let pathImage = "https://image.tmdb.org/t/p/w500"
    
    func getPopularMovies(page: String, onSuccess: @escaping(JSON) -> Void, onFailure: @escaping(Error) -> Void){
        
        let path = "/movie/popular"
        let page = "&page=" + page
        let url : String = baseURL + path + apiKey + page 
        
        print("URL: \(url)")
        let request: NSMutableURLRequest = NSMutableURLRequest(url: NSURL(string: url)! as URL)
        request.httpMethod = "GET"
        let session = URLSession.shared
        
        let task = session.dataTask(with: request as URLRequest, completionHandler: {data, response, error -> Void in
            
            guard let data = data else { return }
            
            if(error != nil){
                onFailure(error!)
            } else{
                let result = JSON(data)
                print(String(describing: result))
                onSuccess(result)
            }
        })
        
        task.resume()
        
    }
    
    func getMovie(idMovie: String, onSuccess: @escaping(JSON) -> Void, onFailure: @escaping(Error) -> Void){
        
        let path = "/movie/"
        let url : String = baseURL + path + idMovie + apiKey
        
        print("URL: \(url)")
        let request: NSMutableURLRequest = NSMutableURLRequest(url: NSURL(string: url)! as URL)
        request.httpMethod = "GET"
        let session = URLSession.shared
        
        let task = session.dataTask(with: request as URLRequest, completionHandler: {data, response, error -> Void in
            
            guard let data = data else { return }
            
            if(error != nil){
                onFailure(error!)
            } else{
                let result = JSON(data)
                print(String(describing: result))
                onSuccess(result)
            }
        })
        
        task.resume()
        
    }

}

        
        

    

