//
//  MovieCell.swift
//  MovieDB
//
//  Created by Eddwin Paz on 9/6/19.
//  Copyright © 2019 acme dot inc. All rights reserved.
//

import Foundation
import UIKit

class MovieCell: UICollectionViewCell {
    var viewModel: MovieViewModel! {
        didSet {
            originalTitle.text = viewModel.originalTitle
            posterImage.loadImageByString(urlString: "https://image.tmdb.org/t/p/w500\(viewModel.posterPath)")

            if viewModel.searchFavorite(viewModel: viewModel) {
                self.favoriteButton.setImage(UIImage(named: "favorite_gray_icon"), for: .normal)
            } else {
                self.favoriteButton.setImage(UIImage(named: "favorite_full_icon"), for: .normal)
            }
        }
    }

    let posterImage: CustomImageView = {
        let image = CustomImageView()
        image.contentMode = .scaleAspectFill // .scaleToFill
        image.clipsToBounds = true
        image.translatesAutoresizingMaskIntoConstraints = false
        image.layer.cornerRadius = 6.0
        image.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
        return image
    }()

    let originalTitle: UILabel = {
        let label = UILabel()
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.5
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = UIColor(red: 0.47, green: 0.59, blue: 0.66, alpha: 1.0)
        label.numberOfLines = 2
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .left
        label.textColor = UIColor.white
        return label
    }()

    let favoriteButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "favorite_gray_icon"), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    @objc func saveMovie(_ sender: UIButton) {
        if viewModel.searchFavorite(viewModel: viewModel) {
            if viewModel.saveFavorite(viewModel: viewModel) {
                print("save movie")
                self.favoriteButton.setImage(UIImage(named: "favorite_full_icon"), for: .normal)
            }
        }
    }


    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayout()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setupLayout() {

        layer.cornerRadius = 8.0
        layer.borderWidth = 2.0
        layer.borderColor = UIColor.clear.cgColor
        layer.masksToBounds = true
        backgroundColor = UIColor.white

        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOffset = CGSize(width: 0, height: 1.0)
        layer.shadowRadius = 8.0
        layer.shadowOpacity = 0.1
        layer.masksToBounds = false
        layer.shadowPath = UIBezierPath(roundedRect: bounds, cornerRadius: contentView.layer.cornerRadius).cgPath

        addSubview(posterImage)
        addSubview(originalTitle)
        addSubview(favoriteButton)

        favoriteButton.addTarget(self, action: #selector(saveMovie), for: .touchUpInside)


        let posterImageConstrains = [
            posterImage.topAnchor.constraint(equalTo: topAnchor, constant: 0),
            posterImage.leftAnchor.constraint(equalTo: leftAnchor, constant: 0),
            posterImage.rightAnchor.constraint(equalTo: rightAnchor, constant: 0),
            posterImage.heightAnchor.constraint(equalToConstant: 200)
        ]
        NSLayoutConstraint.activate(posterImageConstrains)

        let originalTitleConstrains = [
            originalTitle.topAnchor.constraint(equalTo: posterImage.bottomAnchor, constant: 5),
            originalTitle.leftAnchor.constraint(equalTo: leftAnchor, constant: 10),
            originalTitle.rightAnchor.constraint(equalTo: favoriteButton.leftAnchor, constant: -10)
        ]
        NSLayoutConstraint.activate(originalTitleConstrains)

        let favoriteButtonConstrains = [
            favoriteButton.topAnchor.constraint(equalTo: posterImage.bottomAnchor, constant: 5),
            favoriteButton.rightAnchor.constraint(equalTo: rightAnchor, constant: -10),
            favoriteButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -5),
            favoriteButton.widthAnchor.constraint(equalToConstant: 30)
        ]
        NSLayoutConstraint.activate(favoriteButtonConstrains)

        backgroundColor = UIColor(red: 0.176, green: 0.187, blue: 0.277, alpha: 1.0)
    }
}
