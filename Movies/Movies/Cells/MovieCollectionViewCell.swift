//
//  MovieCollectionViewCell.swift
//  Movies
//
//  Created by Consultor on 12/13/18.
//  Copyright © 2018 Mavzapps. All rights reserved.
//

import UIKit
import AlamofireImage

class MovieCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var moviePosterImageView: UIImageView!
    @IBOutlet weak var movieNameLabel: UILabel!
    
    @IBOutlet weak var movieFavoriteIndicatorImageView: UIImageView!
    
    var movie: Movie? = nil {
        didSet{
            movieNameLabel.text = movie?.title
            if let url = URL(string: "https://image.tmdb.org/t/p/w500\(movie?.poster_path ?? "")" ){
            
                moviePosterImageView.af_setImage(withURL: url)
                
            }
        }
    }
    
}
