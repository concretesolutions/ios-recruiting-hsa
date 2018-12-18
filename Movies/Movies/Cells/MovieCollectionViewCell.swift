//
//  MovieCollectionViewCell.swift
//  Movies
//
//  Created by Consultor on 12/13/18.
//  Copyright © 2018 Mavzapps. All rights reserved.
//

import UIKit
import AlamofireImage

protocol MovieCollectionViewCellDelegate{
    func favoriteAction(id: Int)
}

class MovieCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var moviePosterImageView: UIImageView!
    @IBOutlet weak var movieNameLabel: UILabel!
    
    @IBOutlet weak var movieFavoriteIndicatorImageView: UIButton!
    
    var delegate: MovieCollectionViewCellDelegate? = nil
    
    @IBAction func setFavoriteAction(_ sender: Any) {
        delegate?.favoriteAction(id: viewModel.id)
    }
    
    var viewModel = ViewModel(){
        didSet{
            movieNameLabel.text = viewModel.title
            movieFavoriteIndicatorImageView.setImage((viewModel.isFavorite) ? UIImage(named: "btnFavoriteFull"):UIImage(named: "btnFavoriteEmpty"), for: .normal)
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
        var id = 0
    }
}

