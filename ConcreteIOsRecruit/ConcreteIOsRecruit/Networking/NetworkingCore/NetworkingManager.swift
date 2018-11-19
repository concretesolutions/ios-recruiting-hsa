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
    //this request lets us eaily make any request with little effort. No casting required :)
    func request<T: Codable>(endpoint: Endpoint, completionHandler : @escaping (T?, Error?) -> ()){
        debugPrint(endpoint)
        if let urlRequest = endpoint.urlRequest{
            Alamofire.request(urlRequest).responseData { (response) in
                switch response.result {
                case .success:
                    if let data = response.data{
                        let decoder = JSONDecoder()
                        do{
                            let decodedData = try decoder.decode(T.self, from: data)
                            
                            //save to local cache
                            
                            if decodedData is Storable{
                                //let storingKey = (decodedData as! Storable).key
                                //UserDefaults.standard.set(data, forKey: storingKey)
                                DataManager().save(data: (decodedData as! Storable))
                                
                            }
                            
                            completionHandler(decodedData, nil)
                            return
                        }
                        catch{
                            print("Error while trying to decode response: \(error)")
                            completionHandler(nil, error)
                        }
                    }
                
                case .failure(let error):
                    print("Error in networking request: \(error)")
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
