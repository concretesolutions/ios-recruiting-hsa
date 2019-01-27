//
//  MovieCollectionViewCell.swift
//  MovieApp
//
//  Created by luis.a.rosas.arce on 21/01/19.
//  Copyright © 2019 luis.a.rosas.arce. All rights reserved.
//

import UIKit
import SDWebImage

class MovieCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var moviePictureImage: UIImageView!
    @IBOutlet weak var movieTitle: UILabel!
    @IBOutlet weak var movieFavoriteButton: UIButton!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func loadCell (picture : String, title : String, isFavorite : Bool) {
        movieTitle.text = title
        movieTitle.textColor = UIColor(red: 246.0/255.0, green: 206.0/255.0, blue: 91.0/255.0, alpha: 1.0)
        movieTitle.numberOfLines = 0
        
        let nameImage = isFavorite ? "favorite_full_icon" : "favorite_gray_icon"
        movieFavoriteButton .setImage(UIImage(named: nameImage), for:.normal)
        
        moviePictureImage.image = UIImage(named: "imageTest")
        moviePictureImage.contentMode = .scaleAspectFit
        moviePictureImage.sd_setImage(with: URL(string: picture), placeholderImage: UIImage(named: ""))
        
        
    }
}
