//
//  DetailMovieViewController.swift
//  ios-recruiting-hsa
//
//  Created by Hans Fehrmann on 5/31/19.
//  Copyright © 2019 Hans Fehrmann. All rights reserved.
//

import Foundation
import UIKit
import Kingfisher

class DetailMovieViewController: UIViewController {

    @IBOutlet private weak var posterImageView: UIImageView!
    @IBOutlet private weak var favoriteIcon: UIImageView!
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var genresLabel: UILabel!
    @IBOutlet private weak var yearLabel: UILabel!
    @IBOutlet private weak var descriptionLabel: UILabel!

    private var viewModel: DetailMovieViewModel

    init(viewModel: DetailMovieViewModel) {
        self.viewModel = viewModel
        super.init(nibName: "DetailMovie", bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("Use other init")
    }

    override func viewDidLoad() {
        self.title = "Detail"

        titleLabel.text = viewModel.titleMovie
        yearLabel.text = viewModel.yearMovie
        descriptionLabel.text = viewModel.descriptionMovie
        if let posterPath = viewModel.posterURL {
            posterImageView.kf.setImage(with: posterPath)
        }
        let palette = UIColor.ListMovie.self
        let favoriteColor = viewModel.isFavorite ? palette.favoriteMovie : palette.nonFavoriteMovie
        favoriteIcon.tintColor = favoriteColor
    }

    @IBAction private func favoriteTap(_ sender: Any) {
        print("Favorite tap")
    }
}
