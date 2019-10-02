//
//  URLSessionHTTPClient.swift
//  Re-Counter
//
//  Created by Andrés Alexis Rivas Solorzano on 7/29/19.
//  Copyright © 2019 Andrés Alexis Rivas Solorzano. All rights reserved.
//

import Foundation

class URLSessionHTTPClient: HTTPClient{
    
    private let session: URLSession
    
    init(session: URLSession = .shared) {
        self.session = session
    }
    
    func executeRequest(request: URLRequest, completion: @escaping (HTTPClient.Result) -> Void) {
        session.dataTask(with: request) { (data, response, error) in
            completion(Result {
                if let error = error {
                    throw error
                } else if let data = data, let response = response as? HTTPURLResponse {
                    return (data, response)
                } else {
                    throw NetworkError.unknow
                }
            })
        }.resume()
        
    }
    
}
