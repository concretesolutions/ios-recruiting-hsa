//
//  FavoriteMovieTableViewCell.swift
//  Concrete-Movies
//
//  Created by Audel Dugarte on 5/1/19.
//  Copyright © 2019 Audel Dugarte. All rights reserved.
//

import UIKit

class FavoriteMovieTableViewCell: UITableViewCell {
    
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var posterImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var releaseDateLabel: UILabel!
    @IBOutlet weak var overviewtext: UITextView!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        
        prepare()
    }
    
    private func prepare(){
        containerView.backgroundColor = Colors.Primary.dark
    }
    
    func setup(movie: FavoritedMovieViewModel){
        posterImageView.imageFromUrlWithAlamofire(urlString: NetworkConstants.baseImagesUrl + movie.posterPath)
        
        titleLabel.text = movie.name
        releaseDateLabel.text = movie.releaseYear
        overviewtext.text = movie.overview
    }
    
}
