//
//  NetworkController.swift
//  TMDB Reloaded
//
//  Created by Miguel Duran on 1/4/19.
//  Copyright © 2018 Miguel Duran. All rights reserved.
//

import Foundation

class NetworkController {
    private let session = URLSession(configuration: .default, delegate: nil, delegateQueue: .main)
    private var requests: [URL: AnyObject] = [:]
    
    func fetchList<A: Decodable>(for url: URL, page: Int, withCompletion completion: @escaping (Result<A>) -> Void) {
        let listRequest = ListRequest<A>(url: url, session: session, page: page)
        requests[listRequest.url] = listRequest
        listRequest.execute { [weak self] result in
            self?.requests[listRequest.url] = nil
            completion(result)
        }
    }
}
