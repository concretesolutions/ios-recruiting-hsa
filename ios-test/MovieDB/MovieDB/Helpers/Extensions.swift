//
//  UIViewControllerExt.swift
//  MovieDB
//
//  Created by Eddwin Paz on 9/6/19.
//  Copyright © 2019 acme dot inc. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController {
    /// Add TabBar Items with Icons out of the box
    ///
    /// - Parameters:
    ///   - controller: UIViewController
    ///   - title: String
    ///   - imageName: String
    /// - Returns: UINavigationController
    func createNavControllerWithTitle(controller: UIViewController,
                                      title: String,
                                      imageName: String) -> UINavigationController {
        let navController = UINavigationController(rootViewController: controller)
        navController.tabBarItem.title = title
        navController.tabBarItem.image = UIImage(named: imageName)
        return navController
    }

    open override func awakeFromNib() {
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
    }
}

let imageCache = NSCache<AnyObject, AnyObject>()

class CustomImageView: UIImageView {
    
    var imageUrlString: String?

    func loadImageByString(urlString: String) {

        imageUrlString = urlString
        let url = URL(string: urlString)!
        image = nil

        if let imageFromCache = imageCache.object(forKey: urlString as AnyObject) as? UIImage {
            image = imageFromCache
            return
        }

        URLSession.shared.dataTask(with: url, completionHandler: {
            data, _, error in
            if error != nil {
                return
            }
            DispatchQueue.main.async {
                let imageToCache = UIImage(data: data!)

                if self.imageUrlString == urlString {
                    self.image = imageToCache
                }

                imageCache.setObject(imageToCache!, forKey: urlString as AnyObject)
            }

        }).resume()
    }
}
