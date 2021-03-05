//
//  MovieCollectionViewCell.swift
//  Movies
//
//  Created by Daniel Nunez on 04-03-21.
//

import UIKit
import SDWebImage

class MovieCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var imgMovie: UIImageView!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var imgFavorite: UIImageView!

    static let identifier = String(describing: MovieCollectionViewCell.self)
    static let nib = UINib(nibName: identifier, bundle: nil)

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func fill(with movie: Movie) {
        lblTitle.text = movie.title
        imgFavorite.isHidden = !movie.isFavorite
        imgMovie.sd_setImage(with: movie.imgURL)

    }

}
