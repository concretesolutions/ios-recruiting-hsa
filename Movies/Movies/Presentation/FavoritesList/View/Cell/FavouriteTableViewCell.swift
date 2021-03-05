//
//  FavouriteTableViewCell.swift
//  Movies
//
//  Created by Daniel Nunez on 05-03-21.
//

import UIKit
import SDWebImage

class FavouriteTableViewCell: UITableViewCell {

    static let identifier = String(describing: FavouriteTableViewCell.self)
    static let nib = UINib(nibName: identifier, bundle: nil)

    @IBOutlet weak var imgMovie: UIImageView!

    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblRelease: UILabel!
    @IBOutlet weak var lblDesc: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func fill(with movie: Movie) {

        lblTitle.text = movie.title
        lblRelease.text = movie.title
        lblDesc.text = movie.overview
        imgMovie.sd_setImage(with: movie.imgURL)

    }

    
}
