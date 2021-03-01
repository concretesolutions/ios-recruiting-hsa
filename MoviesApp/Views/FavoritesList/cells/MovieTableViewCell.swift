//
//  MovieTableViewCell.swift
//  MoviesApp
//
//  Created by Hector Morales on 2/28/21.
//

import UIKit
import SDWebImage

class MovieTableViewCell: UITableViewCell {

    @IBOutlet weak var bannerImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var overviewLabel: UILabel!
    @IBOutlet weak var yearLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func setup(movie: Movie){
        titleLabel.text = movie.title
        bannerImageView.sd_setImage(with: movie.bannerURL)
        overviewLabel.text = movie.overview
        yearLabel.text = movie.year
    }

    static let identifier = "MovieTableViewCell"
    static let nib = UINib(nibName: identifier, bundle: nil)

    
}
