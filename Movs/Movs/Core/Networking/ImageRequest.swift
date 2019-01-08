//
//  ImageRequest.swift
//  Movs
//
//  Created by Miguel Duran on 1/6/19.
//  Copyright © 2019 Miguel Duran. All rights reserved.
//

import UIKit

class ImageRequest {
    var url: URL
    let session: URLSession
    var task: URLSessionDataTask?
    
    init(url: URL, imagePath: String, session: URLSession) {
        self.url = url
        self.session = session
        self.url.appendPathComponent(imagePath)
    }
}

extension ImageRequest: NetworkRequest {
    var urlRequest: URLRequest {
        return URLRequest(url: url)
    }
    
    func deserialize(_ data: Data?, response: HTTPURLResponse) throws -> UIImage {
        guard let data = data, let image = UIImage(data: data) else {
            throw NetworkError.unrecoverable
        }
        return image
    }
}
