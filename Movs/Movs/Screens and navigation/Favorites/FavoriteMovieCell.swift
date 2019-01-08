//
//  FavoriteMovieCell.swift
//  Movs
//
//  Created by Miguel Duran on 1/8/19.
//  Copyright © 2019 Miguel Duran. All rights reserved.
//

import UIKit

class FavoriteMovieCell: UITableViewCell {
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var yearLabel: UILabel!
    @IBOutlet private weak var overviewLabel: UILabel!
    @IBOutlet private weak var posterImageView: UIImageView!

    var viewModel = ViewModel() {
        didSet {
            titleLabel.text = viewModel.title
            yearLabel.text = viewModel.year
            overviewLabel.text = viewModel.overview
            posterImageView.image = viewModel.poster
        }
    }
    
    var posterImage = UIImage() {
        didSet {
            posterImageView.image = posterImage
        }
    }
}

extension FavoriteMovieCell {
    struct ViewModel {
        var title = ""
        var year = ""
        var overview = ""
        var poster = UIImage()
    }
}

extension FavoriteMovieCell.ViewModel {
    init(movie: Movie, posterImage: UIImage = UIImage()) {
        title = movie.title
        year = movie.releaseDate.year
        overview = movie.overview
        poster = posterImage
    }
}
