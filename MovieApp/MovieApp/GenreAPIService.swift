//
//  GenreAPIService.swift
//  MovieApp
//
//  Created by Sebastian Diaz on 4/7/19.
//  Copyright © 2019 Accenture. All rights reserved.
//

import Foundation
import Alamofire


class GenreAPIService {
    
    typealias SuccessHandler = (_ result:AnyObject)-> Void
    typealias ErrorHandler = (_ error: String) -> Void
    typealias TimeOutHandler = () -> Void
    
    static let shared = GenreAPIService()
    var sessionManager : Alamofire.SessionManager!
    
    fileprivate init (){
        let configuracion = URLSessionConfiguration.default
        configuracion.timeoutIntervalForRequest = 10
        configuracion.timeoutIntervalForResource = 10
        sessionManager = Alamofire.SessionManager(configuration: configuracion)
    }
    
    func responseHandler(response : DataResponse<Any>, success : @escaping SuccessHandler, fail: ErrorHandler, timeOut:TimeOutHandler){
        switch response.result {
        case let .success(value):
            let jsonValue = value as! [String:AnyObject]
            if let result = jsonValue["genres"] {
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
    
    func getGenres(success: @escaping SuccessHandler,fail: @escaping ErrorHandler, timeOut: @escaping TimeOutHandler){
        sessionManager.request(GenreAPIRouter.getGenre).validate().responseJSON { (dataResponse) in
            self.responseHandler(response: dataResponse, success: { (data) in
                success(data)
            }, fail: { (error) in
                fail(error)
            }, timeOut: {
                timeOut()
            })
        }
    }
    
    
    
}
