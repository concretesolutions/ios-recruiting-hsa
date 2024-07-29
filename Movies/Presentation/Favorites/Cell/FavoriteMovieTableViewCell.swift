//
//  FavoriteMovieTableViewCell.swift
//  Movies
//
//  Created by Pedro on 24-07-24.
//

import UIKit

class FavoriteMovieTableViewCell: UITableViewCell {
    var posterImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.heightAnchor.constraint(equalToConstant: 120).isActive = true
        imageView.widthAnchor.constraint(equalTo: imageView.heightAnchor).isActive = true
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    var titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 18, weight: .bold)
        label.numberOfLines = 2
        return label
    }()
    var releaseYearLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .medium)
        return label
    }()
    var overviewLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .regular)
        label.numberOfLines = 0
        return label
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setupViews() {
        let stackView = UIStackView(arrangedSubviews: [
            posterImageView
        ])
        stackView.axis = .horizontal
        let detailStack = UIStackView(arrangedSubviews: [
            titleLabel,
            releaseYearLabel,
            overviewLabel
        ])
        detailStack.axis = .vertical
        detailStack.spacing = 5
        let margin = 5.0
        stackView.layoutMargins = UIEdgeInsets(top: margin, left: margin, bottom: margin, right: margin)
        detailStack.isLayoutMarginsRelativeArrangement = true

        stackView.addArrangedSubview(detailStack)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(stackView)

        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            stackView.topAnchor.constraint(equalTo: contentView.topAnchor),
            stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor)
        ])
        let bottomConstraint = stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        bottomConstraint.priority = .defaultLow
        bottomConstraint.isActive = true
    }
}
