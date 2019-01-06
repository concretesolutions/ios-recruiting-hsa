//
//  MovieCollectionViewCell.swift
//  TMDB Reloaded
//
//  Created by Miguel Duran on 1/6/19.
//  Copyright © 2019 Miguel Duran. All rights reserved.
//

import UIKit

protocol MovieCollectionViewCellDelegate: AnyObject {
    func favoriteSelected()
}

class MovieCollectionViewCell: UICollectionViewCell {
    @IBOutlet fileprivate weak var titleLabel: UILabel!
    @IBOutlet fileprivate weak var posterImageView: UIImageView!
    @IBOutlet fileprivate weak var favoriteButton: UIButton!
    
    weak var delegate: MovieCollectionViewCellDelegate?
    
    var viewModel = ViewModel() {
        didSet {
            titleLabel.text = viewModel.title
            posterImageView.image = viewModel.posterImage
            favoriteButton.isSelected = viewModel.isFavorite
        }
    }
    
    @IBAction func favoriteAction(_ sender: Any) {
        delegate?.favoriteSelected()
    }
}

extension MovieCollectionViewCell {
    struct ViewModel {
        var title = ""
        var posterImage = UIImage()
        var isFavorite = false
    }
}
