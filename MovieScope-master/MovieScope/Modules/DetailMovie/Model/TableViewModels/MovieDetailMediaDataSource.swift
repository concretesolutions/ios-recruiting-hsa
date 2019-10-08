//
//  MovieDetailMediaDataSource.swift
//  MovieScope
//
//  Created by Andrés Alexis Rivas Solorzano on 7/7/19.
//  Copyright © 2019 Andrés Alexis Rivas Solorzano. All rights reserved.
//

import Foundation
import UIKit

class MovieDetailMediaDataSource: NSObject, MovieDetailTableViewDataSource{
    
    var sections:[MovieMediaSection] = []
    
    init(movieMedia: MovieMediaModel){
        
        if let videoMedia = movieMedia.movieVideos, videoMedia.videoList.count > 0{
            let movieSection = MovieDetailMediaDataSource.getVideoSection(mediaVideo: videoMedia)
            sections.append(movieSection)
        }
        
        let imageSections = MovieDetailMediaDataSource.getImagesSections(forMedia: movieMedia)
        
        sections.append(contentsOf: imageSections)
    }
    
    private class func getImagesSections(forMedia: MovieMediaModel)->[MovieMediaSection]{
        
        var sections: [MovieMediaSection] = []
        
        guard let movieImages = forMedia.movieImages else { return sections }
        
        let backDropsFiles = movieImages.backdrops.map {
            MediaSourceModel(sourcePath: $0.filePath, sourceSite: nil, description: nil)
        }
        
        if backDropsFiles.count > 0{
            let backDropSection = MovieMediaSection.init(type: .images, title: "Images", mediaSourceList: backDropsFiles)
            sections.append(backDropSection)
        }

        
        let posterFiles = movieImages.posters.map {
            MediaSourceModel(sourcePath: $0.filePath, sourceSite: nil, description: nil)
        }
        
        if posterFiles.count > 0{
            let posterSection = MovieMediaSection.init(type: .images, title: "Posters", mediaSourceList: posterFiles)
            sections.append(posterSection)
        }
        
        return sections
    }
    
    private class func getVideoSection(mediaVideo: MovieVideoModel)->MovieMediaSection{
        let videoItems = mediaVideo.videoList.map{
            MediaSourceModel(sourcePath: $0.key, sourceSite: $0.site, description: $0.name)
        }
        return MovieMediaSection(type: .videos, title: "Videos", mediaSourceList: videoItems)
    }
    
   
    /* DataSource functions */
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sections[section].mediaSourceList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let section = sections[indexPath.section]
        let cell = tableView.dequeueReusableCell(withIdentifier: section.cellReuseIdentifier, for: indexPath)
       
        if let cell = cell as? MovieMediaConfigurableCell{
            let viewModel = section.getViewModel(forIndex: indexPath.row)
            cell.updateInfo(viewModel: viewModel)
        }
        
        return cell
    }
    
    
}
