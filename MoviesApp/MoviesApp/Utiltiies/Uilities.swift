//
//  Uilities.swift
//  MoviesApp
//
//  Created by gustavo.salazar on 17/06/22.
//

import Foundation
import UIKit
/*
extension UIImageView {
    func loadFrom(URLAddress: String, completion:((_ msg: String) -> Void)? = nil) {
        guard let url = URL(string: URLAddress) else {
            return
        }
        DispatchQueue.main.async { [weak self] in
            if let imageData = try? Data(contentsOf: url) {
                if let loadedImage = UIImage(data: imageData) {
                        self?.image = loadedImage
                    if let completion = completion {
                        completion("OK") }
                }
            }
        }
    }
}*/
extension UIImageView {
    func imageFromServerURL(urlString: String, placeHolderImage: UIImage, completion:((_ msg: String) -> Void)? = nil) {
        if self.image == nil {
            self.image = placeHolderImage
        }
        URLSession.shared.dataTask(with: URL(string: urlString)!) { (data, _, error) in
            if error != nil {
                return
            }
            DispatchQueue.main.async {
                guard let data = data else {return}
                let image = UIImage(data: data)
                self.image = image
                if let completion = completion {
                    completion("OK") }
            }
        }.resume()
 }
}

enum UrlFail: Error {
    case fail
}
