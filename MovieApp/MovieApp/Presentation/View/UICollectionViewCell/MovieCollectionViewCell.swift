//
//  MovieCollectionViewCell.swift
//  MovieApp
//
//  Created by luis.a.rosas.arce on 21/01/19.
//  Copyright © 2019 luis.a.rosas.arce. All rights reserved.
//

import UIKit

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
        
        movieFavoriteButton .setImage(UIImage(named: "favorite_gray_icon"), for:.normal)
        movieFavoriteButton .setImage(UIImage(named: "favorite_full_icon"), for:.selected)
        movieFavoriteButton.isSelected = isFavorite
        
        moviePictureImage.image = UIImage(named: "imageTest")
        moviePictureImage.contentMode = .scaleAspectFit
        
        
    }
}
