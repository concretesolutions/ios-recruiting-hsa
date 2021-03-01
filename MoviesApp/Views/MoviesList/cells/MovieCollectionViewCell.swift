//
//  MovieCollectionViewCell.swift
//  MovieApp
//
//  Created by Hector Morales on 2/27/21.
//

import UIKit
import SDWebImage

class MovieCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var bannerImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var favoriteButton: UIButton!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func setup(movie: Movie){
        titleLabel.text = movie.title
        bannerImageView.sd_setImage(with: movie.bannerURL)
    }

    static let identifier = "MovieCollectionViewCell"
    static let nib = UINib(nibName: identifier, bundle: nil)

}
