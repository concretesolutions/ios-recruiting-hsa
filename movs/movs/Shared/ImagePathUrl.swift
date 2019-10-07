//
//  ImagePathUrl.swift
//  movs
//
//  Created by Andrés Alexis Rivas Solorzano on 10/3/19.
//  Copyright © 2019 Andrés Alexis Rivas Solorzano. All rights reserved.
//

import Foundation

protocol ImagePathURL{
    func getImageURL(forPath: String?, imageSize: SupportedImageSizes) -> URL?
}

extension ImagePathURL{
    
    func getImageURL(forPath: String?, imageSize: SupportedImageSizes = .original) -> URL?{
        
        guard let imagePath = forPath else { return nil }
        
        let widthPath = imageSize.rawValue
        
        return URL.init(string: Host.moviedbImages.rawValue.appending(widthPath).appending(imagePath))
        
    }
}
