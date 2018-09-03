
//
//  NewAPI.swift
//  WannaplayMVP
//
//  Created by Leo on 8/23/17.
//  Copyright © 2017 Enzyme VC. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class Connectivity {
    class func isConnectedToInternet() ->Bool {
        return NetworkReachabilityManager()!.isReachable
    }
}

enum baseURLS : String{
    case popularMovies = "https://api.themoviedb.org/3/movie/popular"
    case posters = "https://image.tmdb.org/t/p/w150_and_h225_bestv2/"
    case genres = "https://api.themoviedb.org/3/genre/movie/list"
    case searchMovies = "https://api.themoviedb.org/3/search/movie"
}

class API {
    
    static let shared: API = API()
    var alamoFireManager : SessionManager?
    fileprivate let apiKey : String = "b9d86c5962d09963a27e22e4949e2833"
    
    init() {
        self.alamofire()
    }
    
    func alamofire(){
        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForRequest = 10
        configuration.timeoutIntervalForResource = 10
        alamoFireManager = Alamofire.SessionManager(configuration: configuration)
    }
    
    func getMovies(page : Int , text : String, completion:@escaping (Bool , [Movie]? , Int? , Int?) ->()) {

        let url: String = text.isEmpty ? "\(baseURLS.popularMovies.rawValue)?api_key=\(self.apiKey)&language=es&page=\(page)" :
        "\(baseURLS.searchMovies.rawValue)?api_key=\(self.apiKey)&language=es&page=\(page)&include_adult=false&query=\(text)"
        
        let headers: HTTPHeaders = [
            "Accept": "application/json",
            "Content-Type":"application/json"
        ]
        
        Alamofire.request(url, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: headers).responseJSON  { response in

            switch(response.result) {
            case .success(_):
                if response.response?.statusCode == 200{
                    let json = JSON(response.result.value as Any)
                    guard let results = json["results"].array , let totalPages = json["total_pages"].int , let totalResult = json["total_results"].int else{
                        return completion(false , nil, nil, nil)
                    }
                    var movies : [Movie] = []
                    for item in results{
                        let movie = Movie(jsonData: item)
                        movies.append(movie)
                    }
                    return completion(true , movies, totalPages , totalResult)
                }
                return completion(false, nil, nil, nil)
            case .failure(_):
                return completion(false, nil, nil, nil)
            }
        }
    }
    
    func getGenres( completion:@escaping (Bool , [Genre]?) ->()) {
        let url: String = "\(baseURLS.genres.rawValue)?api_key=\(self.apiKey)&language=es"
        
        let headers: HTTPHeaders = [
            "Accept": "application/json",
            "Content-Type":"application/json"
        ]
        
        Alamofire.request(url, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: headers).responseJSON  { response in
            
            switch(response.result) {
            case .success(_):
                if response.response?.statusCode == 200{
                    let json = JSON(response.result.value as Any)
                    guard let results = json["genres"].array else{
                        return completion(false , nil)
                    }
                    var genres : [Genre] = []
                    for item in results{
                        let genre = Genre(jsonData: item)
                        genres.append(genre)
                    }
                    return completion(true , genres)
                }
                return completion(false, nil)
            case .failure(_):
                return completion(false, nil)
            }
        }
        
        func getMoviesSearch(page : Int  , completion:@escaping (Bool , [Movie]? , Int? , Int?) ->()) {
            
            let headers: HTTPHeaders = [
                "Accept": "application/json",
                "Content-Type":"application/json"
            ]
            
            Alamofire.request(url, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: headers).responseJSON  { response in
                
                switch(response.result) {
                case .success(_):
                    if response.response?.statusCode == 200{
                        let json = JSON(response.result.value as Any)
                        guard let results = json["results"].array , let totalPages = json["total_pages"].int , let totalResult = json["total_results"].int else{
                            return completion(false , nil, nil, nil)
                        }
                        var movies : [Movie] = []
                        for item in results{
                            let movie = Movie(jsonData: item)
                            movies.append(movie)
                        }
                        return completion(true , movies, totalPages , totalResult)
                    }
                    return completion(false, nil, nil, nil)
                case .failure(_):
                    return completion(false, nil, nil, nil)
                }
            }
        }
    }
    
}
