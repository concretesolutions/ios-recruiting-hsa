//
//  MovieCollectionViewCell.swift
//  TMDB Reloaded
//
//  Created by Miguel Duran on 1/6/19.
//  Copyright © 2019 Miguel Duran. All rights reserved.
//

import UIKit

protocol MovieCollectionViewCellDelegate: AnyObject {
    func movieCell(_ cell: MovieCollectionViewCell)
}

class MovieCollectionViewCell: UICollectionViewCell {
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var posterImageView: UIImageView!
    @IBOutlet private weak var favoriteButton: UIButton!
    
    weak var delegate: MovieCollectionViewCellDelegate?
    
    var viewModel = ViewModel() {
        didSet {
            titleLabel.text = viewModel.title
            posterImageView.image = viewModel.posterImage
            favoriteButton.isSelected = viewModel.isFavorite
        }
    }
    
    var posterImage = UIImage() {
        didSet {
            posterImageView.image = posterImage
        }
    }
    
    var isFavorite = false {
        didSet {
            favoriteButton.isSelected = isFavorite
        }
    }
    
    @IBAction func favoriteAction(_ sender: Any) {
        delegate?.movieCell(self)
    }
}

extension MovieCollectionViewCell {
    struct ViewModel {
        var title = ""
        var posterImage = UIImage()
        var isFavorite = false
    }
}
