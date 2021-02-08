//
//  URLConnection.swift
//  concreteIOSRecruitChallenge
//
//  Created by Kristian Sthefan Cortes Prieto on 04-02-21.
//

import Foundation

class URLConnection: NSObject{
    
    var delegate: ConnectionProtocol?
    var urlRequest = ""
    
    init(_ delegate: ConnectionProtocol) {
        self.delegate = delegate
    }
    
    func connect(_ URL: String,method: String, json: String?, params: [String : String]?, headers: [String : String]?){
        self.urlRequest = URL
        if(params != nil){
            var paramsString = ""
            for (key, value) in params! {
                paramsString = "\(paramsString == "" ? "?" : "\(paramsString)&")\(key)=\(value)"
            }
            self.urlRequest = "\(self.urlRequest)\(paramsString)"
        }
        
        let encodedString = self.urlRequest.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlFragmentAllowed)
        let url = Foundation.URL(string: encodedString!.replacingOccurrences(of: " ", with: "+", options: NSString.CompareOptions.literal, range: nil))
        URLCache.shared.removeAllCachedResponses()
        
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
                json=(json as NSString).substring(to: json.count - 1).replacingOccurrences(of: "Optional(", with: "")
                self.returnData(json)
            }
        }
        task.resume()
    }
    
    func returnData(_ data: String){
        let dic = Util.stringJsonToDictionary(data)
        dic.count > 0 ? delegate?.setFromData(dic, self.urlRequest) : delegate?.errorFromRequest(self.urlRequest)
    }
    
    func errorData(_ data: String){
        delegate?.errorFromRequest(self.urlRequest)
    }
}

protocol ConnectionProtocol: class{
    func setFromData(_ json:[String:AnyObject], _ url: String)
    func errorFromRequest(_ url: String)
}
