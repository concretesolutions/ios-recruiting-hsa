//
//  URLComponentsExtension.swift
//  Re-Counter
//
//  Created by Andrés Alexis Rivas Solorzano on 7/30/19.
//  Copyright © 2019 Andrés Alexis Rivas Solorzano. All rights reserved.
//

import Foundation

extension URLComponents{
    
    init(service: ServiceRequest, enviroment: Enviroment){
        
        guard let baseURL = URL.init(string: enviroment.host) else{
            fatalError("Enviroment not supported")
        }
        
        let url = baseURL.appendingPathComponent(service.path)
        
        self.init(url: url, resolvingAgainstBaseURL: false)!
        
        guard let params = service.urlQueryParams else { return }
        
        queryItems = params.map{ key, value in
            return URLQueryItem.init(name: key, value: String.init(describing: value))
        }
        
    }
    
}
