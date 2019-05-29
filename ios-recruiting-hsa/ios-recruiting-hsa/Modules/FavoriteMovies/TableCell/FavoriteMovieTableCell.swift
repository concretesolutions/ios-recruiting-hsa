//
//  FavoriteMovieTableCell.swift
//  ios-recruiting-hsa
//
//  Created by Hans Fehrmann on 5/28/19.
//  Copyright © 2019 Hans Fehrmann. All rights reserved.
//

import Foundation
import UIKit

class FavoriteMovieTableCell: UITableViewCell {

    private var posterImageView: UIImageView!
    private var titleLabel: UILabel!
    private var yearLabel: UILabel!
    private var descriptionLabel: UILabel!

    private let rightInset: CGFloat = 15
    private let imageInset: CGFloat = 10

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        commonInit()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func commonInit() {
        backgroundColor = .darkCell
        setPoster()
        setTitle()
        setYear()
        setDescription()
    }

    private func setPoster() {
        posterImageView = UIImageView()
        addSubview(posterImageView)
        posterImageView.translatesAutoresizingMaskIntoConstraints = false
        let ratio = posterImageView.widthAnchor.constraint(
            equalTo: heightAnchor,
            multiplier: 0.8
        )
        posterImageView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        posterImageView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        posterImageView.heightAnchor.constraint(equalTo: heightAnchor).isActive = true
        ratio.isActive = true
    }

    private func setTitle() {
        titleLabel = UILabel()
        titleLabel.text = "Very Long title Very Long title Very Long title Very Long title Very Long title" // swiftlint:disable:this line_length
        titleLabel.font = .systemFont(ofSize: 16, weight: .medium)
        titleLabel.numberOfLines = 2

        addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        let trailingConstraint = titleLabel.leadingAnchor.constraint(
            equalTo: posterImageView.trailingAnchor,
            constant: imageInset
        )
        titleLabel.centerYAnchor.constraint(equalTo: topAnchor, constant: 23).isActive = true
        trailingConstraint.isActive = true
    }

    private func setYear() {
        yearLabel = UILabel()
        yearLabel.text = "2008"
        yearLabel.font = .systemFont(ofSize: 14, weight: .regular)
        yearLabel.numberOfLines = 1
        yearLabel.setContentCompressionResistancePriority(
            UILayoutPriority(rawValue: 751),
            for: .horizontal
        )

        addSubview(yearLabel)
        yearLabel.translatesAutoresizingMaskIntoConstraints = false
        let trailingConstraint = trailingAnchor.constraint(
            equalTo: yearLabel.trailingAnchor,
            constant: rightInset
        )
        let greaterConstraint = yearLabel.leadingAnchor.constraint(
            greaterThanOrEqualTo: titleLabel.trailingAnchor,
            constant: 10
        )
        yearLabel.centerYAnchor.constraint(equalTo: titleLabel.centerYAnchor).isActive = true
        greaterConstraint.isActive = true
        trailingConstraint.isActive = true
    }

    private func setDescription() {
        descriptionLabel = UILabel()
        descriptionLabel.text = "Very Litle Long Very Litle Long Very Litle Long Very Litle Long Very Litle Long Very Litle Long Very Litle Long Very Litle Long Very Litle Long Very Litle Long Very Litle Long Very Litle Long Very Litle Long Very Litle Long Very Litle Long Very Litle Long Very Litle Long Very Litle Long Very Litle Long Very Litle Long Very Litle Long Very Litle Long Very Litle Long Very Litle Long Very Litle Long Very Litle Long" // swiftlint:disable:this line_length
        descriptionLabel.font = .systemFont(ofSize: 12, weight: .regular)
        descriptionLabel.numberOfLines = 3

        addSubview(descriptionLabel)
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        let trailingConstraint = descriptionLabel.leadingAnchor.constraint(
            equalTo: posterImageView.trailingAnchor,
            constant: imageInset
        )
        let bottomConstraint = bottomAnchor.constraint(
            equalTo: descriptionLabel.bottomAnchor,
            constant: 10
        )
        let leadingConstraint = trailingAnchor.constraint(
            greaterThanOrEqualTo: descriptionLabel.trailingAnchor,
            constant: rightInset
        )
        bottomConstraint.isActive = true
        leadingConstraint.isActive = true
        trailingConstraint.isActive = true
    }
}
