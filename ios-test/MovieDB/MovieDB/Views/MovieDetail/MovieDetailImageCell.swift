//
//  MovieDetailImageCell.swift
//  MovieDB
//
//  Created by Eddwin Paz on 9/7/19.
//  Copyright © 2019 acme dot inc. All rights reserved.
//

import UIKit

class MovieDetailImageCell: UITableViewCell {
    var viewModel: MovieCellRows! {
        didSet {
            posterImage.loadImageByString(urlString: "https://image.tmdb.org/t/p/w500\(viewModel.text)")
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

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        addSubview(posterImage)

        let posterImageConstrains = [
            posterImage.topAnchor.constraint(equalTo: topAnchor, constant: 0),
            posterImage.leftAnchor.constraint(equalTo: leftAnchor, constant: 0),
            posterImage.rightAnchor.constraint(equalTo: rightAnchor, constant: 0),
            posterImage.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 0),
            posterImage.heightAnchor.constraint(equalToConstant: 550),
        ]
        NSLayoutConstraint.activate(posterImageConstrains)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        backgroundColor? = UIColor.white
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
