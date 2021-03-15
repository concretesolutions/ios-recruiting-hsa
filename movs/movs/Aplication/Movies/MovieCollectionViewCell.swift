//
//  MovieCollectionViewCell.swift
//  movs
//
//  Created by Carlos Petit on 13-03-21.
//

import UIKit

class MovieCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var MovieImageViewCell: UIImageView!
    @IBOutlet weak var MovieTitleViewCell: UILabel!
    var numberRow = 0

    
    func setUp(with movie: MovieViewModel, indexPath: Int){
        MovieImageViewCell.load(url: movie.image)
        MovieImageViewCell.contentMode = .scaleToFill
        MovieTitleViewCell.text = movie.title
        MovieTitleViewCell.adjustsFontSizeToFitWidth = true
    }
}
