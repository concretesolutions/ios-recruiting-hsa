//
//  FavoriteTableViewCell.swift
//  Movies
//
//  Created by Daniel Nunez on 05-03-21.
//

import UIKit
import SDWebImage

class FavoriteTableViewCell: UITableViewCell {

    static let identifier = String(describing: FavoriteTableViewCell.self)
    static let nib = UINib(nibName: identifier, bundle: nil)

    @IBOutlet weak var imgMovie: UIImageView!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var release: UILabel!
    @IBOutlet weak var desc: UILabel!

    func fill(with movie: Movie) {

        title.text = movie.title
        imgMovie.sd_setImage(with: movie.imgURL)
//        release.text = movie.releaseDate
        desc.text = movie.overview

    }
    
}
