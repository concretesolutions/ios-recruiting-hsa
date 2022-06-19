//
//  FavoriteCollectionViewCell.swift
//  MoviesApp
//
//  Created by gustavo.salazar on 19/06/22.
//

import UIKit

class FavoriteViewCell: UITableViewCell {
    
    @IBOutlet weak var posterImage: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var yearReleaseLabel: UILabel!
    @IBOutlet weak var sinopsisLabel: UILabel!
    
    func configureCell(movie:MovieDB){
        posterImage.loadFrom(URLAddress: APIUrl.routeImage + movie.poster)
        titleLabel.text = movie.title
        yearReleaseLabel.text = String(movie.releaseYear)
        sinopsisLabel.text = movie.sinopsis
    }
}
