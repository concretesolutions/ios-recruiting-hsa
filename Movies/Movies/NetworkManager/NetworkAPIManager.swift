//
//  NetworkAPIManager.swift
//  Movies
//
//  Created by Consultor on 12/12/18.
//  Copyright © 2018 Mavzapps. All rights reserved.
//

import Foundation
import Alamofire

public class NetworkAPIManager {
    
    let baseUrl: String = "https://api.themoviedb.org/3/"
    
    let apiKey: String = "b3939aaddfa3bcb1138a5a5e6e2d0f1c"
    
    let baseUrlImages: String = "https://image.tmdb.org/t/p/w500"
    
    init(){
        
    }
    
    func request<T:Codable>(urlString: MoviesAPIUrl, params: [String:Any], completionHandler:@escaping (T?, ErrorTypes?)-> Void) {
        
        Alamofire.request(baseUrl + urlString.rawValue, method: .get, parameters: params, encoding: URLEncoding.default).responseData { response in
            debugPrint("All Response Info: \(response)")
            
            if let data = response.result.value, let utf8Text = String(data: data, encoding: .utf8) {
                print("Data: \(utf8Text)")
                let moviesResponse = try? JSONDecoder().decode(T.self, from: data)
                completionHandler(moviesResponse, nil)
            } else {
                completionHandler(nil,ErrorTypes.networkError)
            }
        }
    }
}

public enum MoviesAPIUrl: String{
    case popularMovies = "movie/popular"
    case genre = "genre/movie/list"
}
