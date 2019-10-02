//
//  URLRequestExtension.swift
//  Re-Counter
//
//  Created by Andrés Alexis Rivas Solorzano on 7/30/19.
//  Copyright © 2019 Andrés Alexis Rivas Solorzano. All rights reserved.
//

import Foundation

extension URLRequest{
    
    init(service: ServiceRequest, enviroment: Enviroment) {
        
        let urlComponents = URLComponents.init(service: service, enviroment: enviroment)
        
        guard let url = urlComponents.url else{
            fatalError("URLComponents url not valid")
        }
       
        self.init(url: url)
        
        httpMethod = service.method.rawValue
        if let bodyParams = service.bodyParams,
            let jsonData = try? JSONSerialization.data(withJSONObject: bodyParams, options: []){
            httpBody = jsonData
        }
        service.headers?.forEach({
            addValue($0.value, forHTTPHeaderField: $0.key)
        })
        
    }
    
}
