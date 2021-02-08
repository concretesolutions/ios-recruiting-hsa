//
//  FavoritesViewController.swift
//  concreteIOSRecruitChallenge
//
//  Created by Kristian Sthefan Cortes Prieto on 04-02-21.
//

import Foundation

class URLConnection: NSObject{
    
    var delegate: ConnectionProtocol?
    var action:String
    
    override init(){
        self.action = ""
    }
    init(_ delegate: ConnectionProtocol) {
        self.action = ""
        self.delegate = delegate
    }
    
    func connect(_ URL: String,method: String, json: String?, headers:Dictionary <String, String>?, action: String){
        let encodedString = URL.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlFragmentAllowed)
        let url = Foundation.URL(string: encodedString!.replacingOccurrences(of: " ", with: "+", options: NSString.CompareOptions.literal, range: nil))
        URLCache.shared.removeAllCachedResponses()
        self.action = action
        
        let cookieStorage: HTTPCookieStorage = HTTPCookieStorage.shared
        let cookies = cookieStorage.cookies(for: url!)
        for coo in cookies! {
            cookieStorage.deleteCookie(coo as HTTPCookie)
        }
        
        let request = NSMutableURLRequest(url: url!, cachePolicy: .reloadIgnoringLocalAndRemoteCacheData, timeoutInterval: 10.0)
        request.httpMethod = method
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        request.httpBody = json?.data(using: String.Encoding.utf8, allowLossyConversion: true)
        
        if(headers != nil){
            for (key, value) in headers! {
                request.setValue(value, forHTTPHeaderField:key)
            }
        }
        
        let nsObject: AnyObject? = Bundle.main.infoDictionary!["CFBundleShortVersionString"] as AnyObject
        let version = nsObject as! String
        if(version != ""){
            request.setValue(version, forHTTPHeaderField:"version")
        }
        request.setValue("iOS", forHTTPHeaderField:"OS")
        request.setValue(String(describing: ProcessInfo.processInfo.operatingSystemVersion), forHTTPHeaderField:"os_version")
        request.setValue("Constants.customerId", forHTTPHeaderField:"customer_id")
        
        let urlconfig = URLSessionConfiguration.default
        urlconfig.timeoutIntervalForRequest = 10
        urlconfig.timeoutIntervalForResource = 10
        urlconfig.waitsForConnectivity = true
        
        let task = URLSession(configuration: urlconfig).dataTask(with: request as URLRequest) {
            (data, response, error) -> Void in
            
            if error != nil {
                self.errorData(String(describing: error))
                return
            } else {
                var json=String(describing: NSString(data: data!, encoding: String.Encoding.utf8.rawValue))
                json=json.replacingOccurrences(of: "Optional(", with: "")
                json=(json as NSString).substring(to: json.count - 1)
                //print(json)
                self.returnData(json)
            }
        }
        task.resume()
    }
    
    func returnData(_ data: String){
        let data2 = Util.stringJsonToDictionary(data)
        if(data2.count>0){
            delegate?.setFromData(data2,action: self.action)
        }else{
            delegate?.errorFromRequest(Util.stringJsonToDictionary(data),action: self.action)
        }
    }
    
    func errorData(_ data: String){
        delegate?.errorFromRequest(Util.stringJsonToDictionary(data),action: self.action)
    }
    
    func runCatching(_ URL: String,method: String, json: String?, headers:Dictionary <String, String>?, action: String, completionHandler: @escaping (Result<[String:AnyObject], NetworkError>) -> Void)  {
        let encodedString = URL.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlFragmentAllowed)
        let url = Foundation.URL(string: encodedString!.replacingOccurrences(of: " ", with: "+", options: NSString.CompareOptions.literal, range: nil))
        URLCache.shared.removeAllCachedResponses()
        self.action = action
        
        let cookieStorage: HTTPCookieStorage = HTTPCookieStorage.shared
        let cookies = cookieStorage.cookies(for: url!)
        for coo in cookies! {
            cookieStorage.deleteCookie(coo as HTTPCookie)
        }
        
        let request = NSMutableURLRequest(url: url!, cachePolicy: .reloadIgnoringLocalAndRemoteCacheData, timeoutInterval: 10.0)
        request.httpMethod = method
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        request.httpBody = json?.data(using: String.Encoding.utf8, allowLossyConversion: true)
        
        if(headers != nil){
            for (key, value) in headers! {
                request.setValue(value, forHTTPHeaderField:key)
            }
        }
        
        let nsObject: AnyObject? = Bundle.main.infoDictionary!["CFBundleShortVersionString"] as AnyObject
        let version = nsObject as! String
        if(version != ""){
            request.setValue(version, forHTTPHeaderField:"version")
        }
        
        request.setValue("iOS", forHTTPHeaderField:"OS")
        request.setValue(String(describing: ProcessInfo.processInfo.operatingSystemVersion), forHTTPHeaderField:"os_version")
        request.setValue("Constants.customerId", forHTTPHeaderField:"customer_id")
        
        let urlconfig = URLSessionConfiguration.default
        urlconfig.timeoutIntervalForRequest = 10
        urlconfig.timeoutIntervalForResource = 10
        urlconfig.waitsForConnectivity = true
        
        let task = URLSession(configuration: urlconfig).dataTask(with: request as URLRequest) {
            (data, response, error) -> Void in
            
            if error != nil {
                completionHandler(.failure(.badURL))
                return
            } else {
                var json=String(describing: NSString(data: data!, encoding: String.Encoding.utf8.rawValue))
                json=json.replacingOccurrences(of: "Optional(", with: "")
                json=(json as NSString).substring(to: json.count - 1)
                
                let data2 = Util.stringJsonToDictionary(json)
                if(data2.count>0){
                    completionHandler(.success(data2))
                }else{
                    completionHandler(.failure(.empty))
                }
            }
        }
        task.resume()
        
        
        
    }
    enum NetworkError: Error {
        case badURL
        case empty
    }
}

protocol ConnectionProtocol: class{
    func setFromData(_ json:[String:AnyObject],action:String)
    func errorFromRequest(_ json:[String:AnyObject],action:String)
}
