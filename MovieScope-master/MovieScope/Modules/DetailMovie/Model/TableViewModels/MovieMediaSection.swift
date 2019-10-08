//
//  MovieMediaSection.swift
//  MovieScope
//
//  Created by Andrés Alexis Rivas Solorzano on 7/7/19.
//  Copyright © 2019 Andrés Alexis Rivas Solorzano. All rights reserved.
//

import Foundation

enum MovieMediaType{
    case images
    case videos
}

struct MovieMediaSection: ImagePathURL{
    
    var type: MovieMediaType
    var title: String
    var mediaSourceList: [MediaSourceModel]
    
    var cellReuseIdentifier: String{
        switch type {
        case .images:
            return MovieMediaImageTableViewCell.reuseIdentifier
        case .videos:
            return MovieMediaVideoTableViewCell.reuseIdentifier
        }
    }
    
    func getViewModel(forIndex: Int)-> MovieMediaViewModel{
        let mediaSource = mediaSourceList[forIndex]
        switch type {
        case .images:
            return MediaImageViewModel.init(filePath: mediaSource.sourcePath)
        case .videos:
            return MediaVideoViewModel.init(videoSource: mediaSource)
        }
    }

}

struct MediaSourceModel{
    var sourcePath: String
    var sourceSite: String?
    var description: String?
}

