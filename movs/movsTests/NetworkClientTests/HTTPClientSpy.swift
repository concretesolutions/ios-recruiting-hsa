//
//  ClientSpy.swift
//  Re-CounterTests
//
//  Created by Andrés Alexis Rivas Solorzano on 7/30/19.
//  Copyright © 2019 Andrés Alexis Rivas Solorzano. All rights reserved.
//

import Foundation
@testable import movs

class HTTPClientSpy: HTTPClient{
    
    typealias spyMessage = (request: URLRequest, completion: (HTTPClient.Result) -> Void)
    private var messages: [spyMessage] = []
    
    var receivedRequests: [URLRequest] {
        return messages.map({$0.request})
    }
    
    func executeRequest(request: URLRequest, completion: @escaping (HTTPClient.Result) -> Void) {
        let newMsg = spyMessage(request, completion)
        messages.append(newMsg)
    }
    
    func completeWithError(error: Error, atIndex: Int = 0){
        messages[atIndex].completion(.failure(error))
    }
    
    func completeWithSucess(statusCode code: Int, data: Data, atIndex: Int = 0){
        
        guard let requestURL = receivedRequests[atIndex].url else{
            fatalError("Not valid request")
        }
        let response = HTTPURLResponse(url: requestURL ,
                                       statusCode: code,
                                       httpVersion: nil,
                                       headerFields: nil)!
        
        messages[atIndex].completion(.success((data, response)))
    }
}
