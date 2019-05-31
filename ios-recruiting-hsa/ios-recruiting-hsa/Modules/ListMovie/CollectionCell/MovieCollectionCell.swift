//
//  MovieCollectionCell.swift
//  ios-recruiting-hsa
//
//  Created by Hans Fehrmann on 5/28/19.
//  Copyright © 2019 Hans Fehrmann. All rights reserved.
//

import Foundation
import UIKit
import Kingfisher

protocol MovieCollectionCell: UICollectionViewCell {
    func configure(with viewModel: MovieCollectionCellViewModel)
}

class MovieCollectionCellImpl: UICollectionViewCell {

    private var movieTitleLabel: UILabel!
    private var favoriteImageView: UIImageView!
    private var moviePosterImageView: UIImageView!

    private var viewModel: MovieCollectionCellViewModel!

    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func commonInit() {
        setPoster()
        setFooter()
        moviePosterImageView.kf.indicatorType = .activity
    }

    private func setPoster() {
        moviePosterImageView = UIImageView()
        moviePosterImageView.contentMode = .scaleAspectFit
        moviePosterImageView.backgroundColor = .black
        addSubview(moviePosterImageView)
        moviePosterImageView.translatesAutoresizingMaskIntoConstraints = false
        moviePosterImageView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        moviePosterImageView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        moviePosterImageView.topAnchor.constraint(equalTo: topAnchor).isActive = true
    }

    private func setFooter() {
        let footer = UIView()
        setInnerFooter(footer)

        footer.backgroundColor = .banner
        addSubview(footer)
        footer.translatesAutoresizingMaskIntoConstraints = false
        footer.topAnchor.constraint(equalTo: moviePosterImageView.bottomAnchor).isActive = true
        footer.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        footer.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        footer.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        footer.heightAnchor.constraint(equalToConstant: 40).isActive = true
    }

    private func setInnerFooter(_ footer: UIView) {
        movieTitleLabel = UILabel()
        movieTitleLabel.textAlignment = .center
        movieTitleLabel.text = "Title"
        movieTitleLabel.numberOfLines = 2
        movieTitleLabel.font = .systemFont(ofSize: 12)
        movieTitleLabel.textColor = .app
        footer.addSubview(movieTitleLabel)
        movieTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        movieTitleLabel.centerXAnchor.constraint(equalTo: footer.centerXAnchor).isActive = true
        movieTitleLabel.centerYAnchor.constraint(equalTo: footer.centerYAnchor).isActive = true

        favoriteImageView = UIImageView()
        favoriteImageView.isUserInteractionEnabled = true
        favoriteImageView.tintColor = UIColor.ListMovie.nonFavoriteMovie
        favoriteImageView.image = .favorite
        let favoriteTap = UITapGestureRecognizer(target: self, action: #selector(favoriteHandle))
        favoriteImageView.addGestureRecognizer(favoriteTap)

        footer.addSubview(favoriteImageView)
        favoriteImageView.translatesAutoresizingMaskIntoConstraints = false

        let trailingConstraint = footer.trailingAnchor.constraint(
            equalTo: favoriteImageView.trailingAnchor,
            constant: 8
        )
        let heightConstraint = favoriteImageView.heightAnchor.constraint(
            equalTo: footer.heightAnchor,
            multiplier: 0.4
        )
        let aspectRatio = favoriteImageView.widthAnchor.constraint(
            equalTo: favoriteImageView.heightAnchor
        )
        favoriteImageView.centerYAnchor.constraint(equalTo: footer.centerYAnchor).isActive = true
        trailingConstraint.isActive = true
        heightConstraint.isActive = true
        aspectRatio.isActive = true

        let minimumSpaceConstraint = favoriteImageView.leadingAnchor.constraint(
            equalTo: movieTitleLabel.trailingAnchor,
            constant: 5
        )
        minimumSpaceConstraint.isActive = true
    }

    @objc private func favoriteHandle() {
        viewModel.toggleFavorite()
    }

    // Public methods

    override func prepareForReuse() {
        moviePosterImageView.kf.cancelDownloadTask()
    }
}

extension MovieCollectionCellImpl: MovieCollectionCell {

    func configure(with viewModel: MovieCollectionCellViewModel) {
        self.viewModel = viewModel

        let palette = UIColor.ListMovie.self
        let tintColor = viewModel.isFavorite ? palette.favoriteMovie : palette.nonFavoriteMovie
        movieTitleLabel.text = viewModel.title
        favoriteImageView.tintColor = tintColor
        if let posterURL = viewModel.posterURL {
            moviePosterImageView.kf.setImage(with: posterURL )
        }

        viewModel.onFavouriteChange = { [unowned self] isFavorite in
            let duration = 0.3
            let palette = UIColor.ListMovie.self
            let color = isFavorite ? palette.favoriteMovie : palette.nonFavoriteMovie
            UIView.animate(withDuration: duration) {
                self.favoriteImageView.tintColor = color
            }
        }
    }
}
