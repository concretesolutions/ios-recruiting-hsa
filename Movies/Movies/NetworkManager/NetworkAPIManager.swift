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
    
    init(){
        
    }
    
    func request(urlString: String, params: [String:Any], completionHandler:@escaping (GenericPagedMovieResponse?)-> Void){
        
        Alamofire.request(baseUrl + urlString, method: .get, parameters: params, encoding: URLEncoding.default).responseData { response in
            debugPrint("All Response Info: \(response)")
            
            if let data = response.result.value, let utf8Text = String(data: data, encoding: .utf8) {
                print("Data: \(utf8Text)")
                let moviesResponse = try? JSONDecoder().decode(GenericPagedMovieResponse.self, from: data)
                print("TotalPages: \(moviesResponse?.total_pages ?? -1)")
                completionHandler(moviesResponse)
                
            }
        }
    }
    
    
}
