//
//  ServiceManager.swift
//  MovieScope
//
//  Created by Andrés Alexis Rivas Solorzano on 7/2/19.
//  Copyright © 2019 Andrés Alexis Rivas Solorzano. All rights reserved.
//

import Foundation
import Alamofire
import CoreData

class NetworkServiceManager{
    
    class var availableConnection: Bool{
        return NetworkReachabilityManager()?.isReachable ?? false
    }
    
    class func request<T: Codable & NSManagedObject>(context: NSManagedObjectContext ,router: ServiceRouter, completion: @escaping (Result<T, Error>) -> ()) {
        

        guard  availableConnection else {
            completion(.failure(NetworkError.noInternet))
            return
        }
        
        AF.request(router).validate(statusCode: 200..<300).response { (response) in
            
            switch response.result{
            case .success(let jsonData):
                guard let jsonData = jsonData else {
                    return
                }
                guard let codingUserInfoKeyManagedObjectContext = CodingUserInfoKey.managedObjectContext else {
                    fatalError("Failed to retrieve context")
                }
                
                let decoder = JSONDecoder()
                decoder.userInfo[codingUserInfoKeyManagedObjectContext] = context
                
                do {
                    let object = try decoder.decode(T.self, from: jsonData)
                    completion(.success(object))
                }catch {
                    completion(.failure(error))
                }
            case .failure(let error):
                completion(.failure(error))
            }
            
        }
    }
}
