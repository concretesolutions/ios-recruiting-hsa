//
//  MovieVideoViewModel.swift
//  MovieScope
//
//  Created by Andrés Alexis Rivas Solorzano on 7/8/19.
//  Copyright © 2019 Andrés Alexis Rivas Solorzano. All rights reserved.
//

import Foundation

protocol MediaVideoViewModelDelegate: class {
    func openExternalVideo(deepLinkStr: String, webURLStr: String)
}

class MediaVideoViewModel: MovieMediaViewModel, ImagePathURL{
    
    var videoItem: MediaSourceModel
    
    var videoName: String?{
        return videoItem.description
    }
    
    var originSite: String{
        return videoItem.sourceSite ?? "el sitio"
    }
    
    weak var delegate: MediaVideoViewModelDelegate?
    init(videoSource: MediaSourceModel) {
        self.videoItem = videoSource
    }
    
    func getThumbnailURL()->URL?{
        let youtubeImageEndPath = "/0.jpg"
        let stringURL =  Host.youtubeImages.rawValue.appending(videoItem.sourcePath).appending(youtubeImageEndPath)
        return URL.init(string: stringURL)
    }
    
    func openVideo(){
        
        guard let supportedSite = SupportedVideoSites.init(rawValue: originSite) else{
            return
        }
        let deppLinkURL: String
        let webURl: String
        
        switch supportedSite {
        case .youtube:
            deppLinkURL = "youtube://\(videoItem.sourcePath)"
            webURl = "https://www.youtube.com/watch?v=\(videoItem.sourcePath)"
        case .vimeo:
            deppLinkURL = "vimeo://app.vimeo.com/videos/\(videoItem.sourcePath)"
            webURl = "https://vimeo.com/\(videoItem.sourcePath)"
        }
        
        delegate?.openExternalVideo(deepLinkStr: deppLinkURL, webURLStr: webURl)
        
    }
    
}
