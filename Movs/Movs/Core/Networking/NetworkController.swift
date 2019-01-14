//
//  NetworkController.swift
//  TMDB Reloaded
//
//  Created by Miguel Duran on 1/4/19.
//  Copyright © 2018 Miguel Duran. All rights reserved.
//

import UIKit

class NetworkController {
    private let session = URLSession(configuration: .default, delegate: nil, delegateQueue: .main)
    private var requests: [URL: AnyObject] = [:]
    private var currentPage = 1
    
    var cache: NSCache<AnyObject, AnyObject> = NSCache()
    
    func fetchList<A: Decodable>(for url: URL, withCompletion completion: @escaping (Result<A>) -> Void) {
        let listRequest = ListRequest<A>(url: url, session: session, page: currentPage)
        requests[listRequest.url] = listRequest
        listRequest.execute { [weak self] result in
            self?.requests[listRequest.url] = nil
            self?.currentPage += 1
            completion(result)
        }
    }
    
    func fecthImage(url: URL, imagePath: String, withCompletion completion: @escaping (Result<UIImage>) -> Void) {
            let imageRequest = ImageRequest(url: url, imagePath: imagePath, session: session)
            requests[imageRequest.url] = imageRequest
            imageRequest.execute { [weak self] result in
                guard let image = try? result.get() else {
                    return
                }
                self?.cache.setObject(image, forKey: imagePath as AnyObject )
                self?.requests[imageRequest.url] = nil
                completion(result)
            }
    }
    
    func fecth<A: Decodable>(url: URL, withCompletion completion: @escaping (Result<A>) -> Void ) {
        let fetchRequest = FetchRequest<A>(url: url, session: session)
        requests[fetchRequest.url] = fetchRequest
        fetchRequest.execute { [weak self] result in
            self?.requests[fetchRequest.url] = nil
            completion(result)
        }
    }
    
    func getImageFromCache(imagePath: String) -> UIImage? {
        let image = self.cache.object(forKey: imagePath as AnyObject) as? UIImage
        return image
    }
}
