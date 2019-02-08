//
//  MovieCollectionViewCell.swift
//  AccentureChallenge
//
//  Created by Jaime on 2/4/19.
//  Copyright © 2019 Jaime. All rights reserved.
//

import UIKit
import Kingfisher

class MovieCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var pictureImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var favoriteImageView: UIImageView!
    
    var movie: Movie! {
        didSet{
            
            titleLabel.text = movie.name
            
            if movie.isFavorite {
                
                favoriteImageView.image = UIImage(named:"icon_favorite_full")
                
            } else {
                
                favoriteImageView.image = UIImage(named:"icon_favorite_gray")
                
            }
            
            let url = URL(string: movie.pictureURL)
            pictureImageView.kf.setImage(with: url!)
            
        }
    }
    
    override func awakeFromNib() {
        
        self.layer.cornerRadius = 8
        self.layer.shadowOpacity = 0.1
        self.layer.shadowOffset = CGSize(width: 5, height: 5)
        self.layer.shadowRadius = 8
        
    }
}
