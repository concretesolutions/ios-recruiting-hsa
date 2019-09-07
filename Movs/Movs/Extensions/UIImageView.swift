//
//  UIImageView.swift
//  Movs
//
//  Created by Jose Antonio Aravena on 9/5/19.
//  Copyright © 2019 Jose Antonio Aravena. All rights reserved.
//

import UIKit

extension UIImageView {
    public func imageFromUrl(urlString: String) {
        if let url = URL(string: urlString) {
            
            URLSession.shared.dataTask(with: url, completionHandler: { data,respose,error in
                
                
                if error != nil {
                    print(error!)
                    return
                }
                
                DispatchQueue.main.async {
                    self.image = UIImage(data: data!)
                    
                }
                
            }).resume()
            
        }
    }
}
