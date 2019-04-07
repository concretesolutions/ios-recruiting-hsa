//
//  MovieAPIService.swift
//  MovieApp
//
//  Created by Sebastian Diaz on 4/4/19.
//  Copyright © 2019 Accenture. All rights reserved.
//

import Foundation
import Alamofire

class MovieAPIService {
    
    typealias SuccessHandler = (_ result:AnyObject)-> Void
    typealias ErrorHandler = (_ error: String) -> Void
    typealias TimeOutHandler = () -> Void
    
    let sessionManager : Alamofire.SessionManager!
    static var shared = MovieAPIService()
    
    fileprivate init(){
        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForRequest = 10 // seconds
        configuration.timeoutIntervalForResource = 10
        sessionManager = Alamofire.SessionManager(configuration: configuration)
    }
    
    
    func responseHandler(response : DataResponse<Any>, success : @escaping SuccessHandler, fail: ErrorHandler, timeOut:TimeOutHandler){
        switch response.result {
        case let .success(value):
            let jsonValue = value as! [String:AnyObject]
            if let result = jsonValue["results"] {
                success(result)
            }
        case let .failure(error):
            switch  error._code{
            case NSURLErrorTimedOut:
                timeOut()
            case NSURLErrorNotConnectedToInternet:
                timeOut()
            default:
                fail(error.localizedDescription)
            }
        }
    }
    
    func getPopularMovies(success: @escaping (AnyObject) -> Void, fail: @escaping ErrorHandler, timeout: @escaping TimeOutHandler) {
        sessionManager.request(RemoteAPIRouter.getPopularMovies(1)).validate().responseJSON(completionHandler: { (dataResponse) in
            self.responseHandler(response: dataResponse, success: { (data) in
                success(data)
            }, fail: { (error) in
                fail(error)
            }, timeOut: {
                timeout()
            })
        })
    }
    
    func getDetailMovie(id : Int, success: @escaping SuccessHandler, fail: @escaping ErrorHandler, timeout: @escaping TimeOutHandler){
        sessionManager.request(RemoteAPIRouter.getDetailMovie(id)).validate().responseJSON { (dataResponse) in
            self.responseHandler(response: dataResponse, success: { (data) in
                success(data)
            }, fail: { (error) in
                fail(error)
            }, timeOut: {
                timeout()
            })
        }
    }
    
    
    
}



