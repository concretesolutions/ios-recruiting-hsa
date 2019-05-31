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
        self.title = viewModel.title

        titleLabel.text = viewModel.titleMovie
        yearLabel.text = viewModel.yearMovie
        descriptionLabel.text = viewModel.descriptionMovie
        genresLabel.text = viewModel.genres
        if let posterPath = viewModel.posterURL {
            posterImageView.kf.setImage(with: posterPath)
        }
        genresLabel.superview?.isHidden = genresLabel.text == ""

        favoriteIcon.tintColor = favoriteColor(ifIs: viewModel.isFavorite)

        viewModel.onFavouriteChange = { [unowned self] isFavorite in
            let duration = 0.3
            let halfDuration = duration / 2
            UIView.animateKeyframes(
                withDuration: duration,
                delay: 0,
                options: [],
                animations: {
                    UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: duration) {
                        self.favoriteIcon.tintColor = self.favoriteColor(ifIs: isFavorite)
                    }
                    UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: halfDuration) {
                        self.favoriteIcon.transform = CGAffineTransform(scaleX: 1.4, y: 1.4)
                    }
                    UIView.addKeyframe(
                        withRelativeStartTime: halfDuration,
                        relativeDuration: halfDuration
                    ) {
                        self.favoriteIcon.transform = .identity
                    }
                },
                completion: nil
            )
        }
    }

    private func favoriteColor(ifIs favorite: Bool) -> UIColor? {
        let palette = UIColor.ListMovie.self
        return favorite ? palette.favoriteMovie : palette.nonFavoriteMovie
    }

    @IBAction private func favoriteTap(_ sender: Any) {
        viewModel.toggleFavorite()
    }
}
