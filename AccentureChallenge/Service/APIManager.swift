//
//  APIManager.swift
//  AccentureChallenge
//
//  Created by Jaime on 2/4/19.
//  Copyright © 2019 Jaime. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

public class APIManager {
    
    public class var sharedInstance: APIManager {
        struct Singleton {
            static let instance : APIManager = APIManager()
        }
        return Singleton.instance
    }
    
    var manager = SessionManager()
    
    init() {
        //        let configuration = URLSessionConfiguration.defaultSessionConfiguration()
        //        configuration.timeoutIntervalForRequest = 12
        //        configuration.timeoutIntervalForResource = 12
        //        self.manager = Alamofire.Manager(configuration: configuration)
    }
    
    func getPopularMovies(page: Int, completion: @escaping (_ isSuccess: Bool, _ jsonResponse: JSON?) -> ()) -> Request{
        
        let router = Router.getPopularMovies(page: page)
        return manager.request(router)
            .validate()
            .responseJSON { response in
                switch response.result {
                case .success(let data):
                    print("SUCCESS")
                    completion(true, JSON(data))
                case .failure(let error):
                    print("FAILURE: \(error)")
                    guard let data = response.data, let utf8Text = String(data: data, encoding: .utf8) else {
                        completion(false, nil)
                        return
                    }
                    completion(false, JSON(parseJSON: utf8Text))
                }
        }
    }
    
    func getMovieTypes(completion: @escaping (_ isSuccess: Bool, _ jsonResponse: JSON?) -> ()) -> Request{
        
        let router = Router.getMovieTypes()
        return manager.request(router)
            .validate()
            .responseJSON { response in
                switch response.result {
                case .success(let data):
                    print("SUCCESS")
                    completion(true, JSON(data))
                case .failure(let error):
                    print("FAILURE: \(error)")
                    guard let data = response.data, let utf8Text = String(data: data, encoding: .utf8) else {
                        completion(false, nil)
                        return
                    }
                    completion(false, JSON(parseJSON: utf8Text))
                }
        }
    }
}




