//
//  MediaImageViewModel.swift
//  MovieScope
//
//  Created by Andrés Alexis Rivas Solorzano on 7/8/19.
//  Copyright © 2019 Andrés Alexis Rivas Solorzano. All rights reserved.
//

import Foundation

class MediaImageViewModel: MovieMediaViewModel, ImagePathURL{
   
    let filePath: String
    
    init(filePath: String) {
        self.filePath = filePath
    }
    
    func getImageURL()->URL?{
        return self.getImageURL(forPath: filePath, imageSize: .w780)
    }
}
