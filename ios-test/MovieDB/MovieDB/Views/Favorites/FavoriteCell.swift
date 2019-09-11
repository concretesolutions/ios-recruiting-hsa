//
//  FavoriteCell.swift
//  MovieDB
//
//  Created by Eddwin Paz on 9/9/19.
//  Copyright © 2019 acme dot inc. All rights reserved.
//

import Foundation
import UIKit

class FavoriteCell: UITableViewCell {
    var viewModel: MovieViewModel! {
        didSet {
            posterImage.loadImageByString(urlString: "https://image.tmdb.org/t/p/w500\(viewModel.posterPath)")
            originalTitleLabel.text = viewModel.originalTitle
            releaseDateLabel.text = viewModel.releaseDate
            overViewLabel.text = viewModel.overview
        }
    }

    var posterImage: CustomImageView = {
        let image = CustomImageView()
        image.image = UIImage(named: "Auto")
        image.translatesAutoresizingMaskIntoConstraints = false
        image.clipsToBounds = true
        image.contentMode = .scaleToFill // .scaleToFill
        return image
    }()

    let originalTitleLabel: UILabel = {
        let label = UILabel()
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 1.0
        label.font = UIFont.systemFont(ofSize: 22)
        label.textColor = UIColor(red: 0.47, green: 0.59, blue: 0.66, alpha: 1.0)
        label.numberOfLines = 2
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .left
        label.textColor = UIColor.black
        return label
    }()

    let releaseDateLabel: UILabel = {
        let label = UILabel()
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 1.0
        label.font = UIFont.systemFont(ofSize: 19)
        label.textColor = UIColor(red: 0.47, green: 0.59, blue: 0.66, alpha: 1.0)
        label.numberOfLines = 1
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .right
        label.textColor = UIColor.black
        return label
    }()

    let overViewLabel: UILabel = {
        let label = UILabel()
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 1.0
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = UIColor(red: 0.47, green: 0.59, blue: 0.66, alpha: 1.0)
        label.numberOfLines = 5
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .left
        label.textColor = UIColor.black
        return label
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        backgroundColor = UIColor(red: 0.847, green: 0.847, blue: 0.851, alpha: 1.0)
        backgroundView?.backgroundColor = UIColor(red: 0.847, green: 0.847, blue: 0.851, alpha: 1.0)

        addSubview(posterImage)
        addSubview(originalTitleLabel)
        addSubview(releaseDateLabel)
        addSubview(overViewLabel)

        let posterImageConstrains = [
            posterImage.topAnchor.constraint(equalTo: topAnchor, constant: CGFloat(0)),
            posterImage.leftAnchor.constraint(equalTo: leftAnchor, constant: CGFloat(0)),
            posterImage.widthAnchor.constraint(equalToConstant: CGFloat(130)),
            posterImage.bottomAnchor.constraint(equalTo: bottomAnchor, constant: CGFloat(0))]
        NSLayoutConstraint.activate(posterImageConstrains)

        let originalTitleLabelConstrains = [
            originalTitleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 6),
            originalTitleLabel.leftAnchor.constraint(equalTo: posterImage.rightAnchor, constant: 10),
            originalTitleLabel.rightAnchor.constraint(equalTo: releaseDateLabel.leftAnchor, constant: -10)]
        NSLayoutConstraint.activate(originalTitleLabelConstrains)

        let releaseDateLabelConstrains = [
            releaseDateLabel.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            releaseDateLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: -10),
            releaseDateLabel.widthAnchor.constraint(equalToConstant: 50)]
        NSLayoutConstraint.activate(releaseDateLabelConstrains)

        let overViewLabelConstrains = [
            overViewLabel.topAnchor.constraint(equalTo: originalTitleLabel.bottomAnchor, constant: 10),
            overViewLabel.leftAnchor.constraint(equalTo: posterImage.rightAnchor, constant: 10),
            overViewLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: -10)]
        NSLayoutConstraint.activate(overViewLabelConstrains)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
