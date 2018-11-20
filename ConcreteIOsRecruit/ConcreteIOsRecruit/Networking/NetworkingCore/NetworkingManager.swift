//
//  NetworkingManager.swift
//  ConcreteIOsRecruit
//
//  Created by Matías Contreras Selman on 11/18/18.
//  Copyright © 2018 Matias Contreras. All rights reserved.
//

import Foundation
import Alamofire

struct NetworkingManager{
    
    let dataManager = DataManager()
    //this request lets us eaily make any request with little effort. No casting required :)
    func request<T: Codable>(endpoint: Endpoint, completionHandler : @escaping (T?, Error?) -> ()){
        if let urlRequest = endpoint.urlRequest{
            Alamofire.request(urlRequest).responseData { (response) in
                switch response.result {
                case .success:
                    if let data = response.data{
                        let decoder = JSONDecoder()
                        do{
                            let decodedData = try decoder.decode(T.self, from: data)
                            
                            //save to local cache
                            self.dataManager.save(object: decodedData)
                            
                            completionHandler(decodedData, nil)
                            return
                        }
                        catch{
                            debugPrint("Error while trying to decode response: \(error)")
                            completionHandler(nil, error)
                        }
                    }
                
                case .failure(let error):
                    debugPrint("Error in networking request: \(error)")
                    
                    //try to load from local cache
                    /*if let object = T.self as? Storable{
                        let storingKey = DataManager.StoringKey(
                        
                        if let localData = DataManager().retrieve(decodingType: T.self, storingKey: object.key){
                            debugPrint(localData)
                        }
                    }*/
                    
                    
                    completionHandler(nil, error)
                
                }
                return
            }
        }
        else{
            fatalError("Error: Cound not create the URL Request.")
        }
    }
}
