//
//  MovieCollectionViewCell.swift
//  Movs
//
//  Created by Jose Antonio Aravena on 9/3/19.
//  Copyright © 2019 Jose Antonio Aravena. All rights reserved.
//

import UIKit

class myCell: UICollectionViewCell {
    @IBOutlet weak var favButton: UIButton!
    var isFavorite = false
    @IBOutlet weak var movieImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()

        /*NSLayoutConstraint.activate([
            movieImage.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 0),
            movieImage.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 0),
            movieImage.topAnchor.constraint(equalTo: self.topAnchor, constant: 25),
            movieImage.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 0)
            ])*/
        
        movieImage.addConstraint(movieImage.widthAnchor.constraint(equalToConstant: self.bounds.width))
        movieImage.addConstraint(movieImage.heightAnchor.constraint(equalToConstant: self.bounds.height))
        
    }

    @IBAction func addToFavorites(_ sender: Any) {
        if !isFavorite{
            favButton.setImage(UIImage(named: "b1"), for: .normal)
            isFavorite=true
        }
        else{
            favButton.setImage(UIImage(named: "b2"), for: .normal)
            isFavorite=false
        }
    }
}
