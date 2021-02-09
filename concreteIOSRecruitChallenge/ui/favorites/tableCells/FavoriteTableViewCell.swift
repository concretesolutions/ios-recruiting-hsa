//
//  FavoriteTableViewCell.swift
//  concreteIOSRecruitChallenge
//
//  Created by Kristian Sthefan Cortes Prieto on 09-02-21.
//

import UIKit

class FavoriteTableViewCell: UITableViewCell {
    
    var movieEntry: MovieEntry?
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func loadCellView(movieEntry: MovieEntry?){
        let titleLabel : UILabel = viewWithTag(2) as! UILabel
        let yearLabel : UILabel = viewWithTag(4) as! UILabel
        let overviewLabel : UILabel = viewWithTag(5) as! UILabel
        let photoImageView : UIImageView = viewWithTag(1) as! UIImageView
        let activityIndicatorView : UIActivityIndicatorView = viewWithTag(3) as! UIActivityIndicatorView
        
        self.movieEntry = movieEntry
        
        titleLabel.text = movieEntry?.title
        yearLabel.text = movieEntry?.getYear()
        overviewLabel.text = movieEntry?.overview
        if let poster = movieEntry?.poster_path { photoImageView.loadFromUrl(url: "\(Constants.imageEndpoint)/t/p/w300/\(poster)", activityIndicator: activityIndicatorView, errorImage: #imageLiteral(resourceName: "empty_photo")) }
    }
}
