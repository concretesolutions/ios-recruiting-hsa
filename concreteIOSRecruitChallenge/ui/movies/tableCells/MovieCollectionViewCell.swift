//
//  MovieCollectionViewCell.swift
//  concreteIOSRecruitChallenge
//
//  Created by Kristian Sthefan Cortes Prieto on 08-02-21.
//

import UIKit

class MovieCollectionViewCell: UICollectionViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func loadCellView(movieEntry: MovieEntry?){
        let titleLabel : UILabel = viewWithTag(2) as! UILabel
        let photoImageView : UIImageView = viewWithTag(1) as! UIImageView
        let activityIndicatorView : UIActivityIndicatorView = viewWithTag(3) as! UIActivityIndicatorView
        
        titleLabel.text = movieEntry?.title
        if let poster = movieEntry?.poster_path { photoImageView.loadFromUrl(url: "\(Constants.imageEndpoint)/t/p/w300/\(poster)", activityIndicator: activityIndicatorView, errorImage: #imageLiteral(resourceName: "empty_photo")) }
    }
}
