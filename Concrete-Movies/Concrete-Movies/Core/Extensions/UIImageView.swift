//
//  UIImage.swift
//  Concrete-Movies
//
//  Created by Audel Dugarte on 4/28/19.
//  Copyright © 2019 Audel Dugarte. All rights reserved.
//

import Foundation
import UIKit
import Alamofire

extension UIImageView {
    public func imageFromUrl(urlString: String) {
        if let url = NSURL(string: urlString) {
            let request = NSURLRequest(url: url as URL)
            NSURLConnection.sendAsynchronousRequest(request as URLRequest, queue: OperationQueue.main) {
                (response: URLResponse!, data: Data!, error: Error!) -> Void in
                if let data = data {
                    self.image = UIImage(data: data)
                }else{
                    self.image = UIImage(named: "error-img")
                }
                
            }
        }
    }
    
    public func imageFromUrlWithAlamofire(urlString: String){
        Alamofire.request(urlString).response { (response) in
            if let data = response.data{
                self.image = UIImage(data: data)
            }else{
                self.image = UIImage(named: "error-img")
            }
        }
            
    }
}
