//
//  MovieListCollectionViewCell.swift
//  movs
//
//  Created by Andrés Alexis Rivas Solorzano on 10/3/19.
//  Copyright © 2019 Andrés Alexis Rivas Solorzano. All rights reserved.
//

import UIKit
import Nuke

class MovieListCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var moviePoster: UIImageView!
    @IBOutlet weak var titleLb: UILabel!
    @IBOutlet weak var favButton: UIButton!
    @IBOutlet weak var titleContainerView: UIView!
    
    private var movieId: Int?
    weak var delegate: FavoriteMovieDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        titleLb.textColor = .white
        titleContainerView.backgroundColor = .darkNavy
    }
    
    func updateInfo(movieItem: MovieModel){
        movieId = movieItem.id
        titleLb.text = movieItem.title
        favButton.isSelected = movieItem.isFavorite ?? false
        if let url = movieItem.getPosterImageURL(withSize: .w300){
            Nuke.loadImage(with: url, into: moviePoster)
        }
    }

    @IBAction func favMovieAction(_ sender: Any) {
        guard let movieId = movieId else { return }
        delegate?.changeFavoriteStatus(for: movieId)
    }
}
