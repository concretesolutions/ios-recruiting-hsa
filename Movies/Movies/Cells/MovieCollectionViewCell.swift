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
    
    var viewModel = ViewModel(){
        didSet{
            movieNameLabel.text = viewModel.title
            movieFavoriteIndicatorImageView.image = (viewModel.isFavorite) ? UIImage(named: "btnFavoriteFull"):UIImage(named: "btnFavoriteEmpty")
            if let url = URL(string: NetworkAPIManager().baseUrlImages+"\(viewModel.imagePath)" ){
                moviePosterImageView.af_setImage(withURL: url)
            }
        }
    }
}
extension MovieCollectionViewCell {
    struct ViewModel{
        var title = ""
        var imagePath = ""
        var isFavorite = false
    }
}

