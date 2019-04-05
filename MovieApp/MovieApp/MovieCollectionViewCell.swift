//
//  MovieCollectionViewCell.swift
//  MovieApp
//
//  Created by Sebastian Diaz on 4/4/19.
//  Copyright © 2019 Accenture. All rights reserved.
//

import UIKit

class MovieCollectionViewCell: UICollectionViewCell {
    
    
    
    
    @IBOutlet weak var movieImage: UIImageView!
    @IBOutlet weak var titleMovieLabel: UILabel!
    @IBOutlet weak var favoriteImage: UIImageView!
    
    var viewModel : MovieViewModel?

    override func awakeFromNib() {
        super.awakeFromNib()
        self.defaultCell()
    }
    
    
    func defaultCell(){
        self.titleMovieLabel.text = ""
        self.favoriteImage.image = UIImage(named: "favorite_gray_icon")
    }
    
    

}
