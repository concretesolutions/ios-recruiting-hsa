//
//  Uilities.swift
//  MoviesApp
//
//  Created by gustavo.salazar on 17/06/22.
//

import Foundation
import UIKit

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
}

enum UrlFail: Error {
    case fail
}
