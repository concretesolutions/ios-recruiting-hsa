//
//  MovieCollectionViewCell.swift
//  Movies
//
//  Created by Pedro on 24-07-24.
//

import UIKit

class MovieCollectionViewCell: UICollectionViewCell {
    weak var delegate: MovieCollectionViewCellDelegate?

    var posterImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    var titleLabel = {
        let label = UILabel()
        label.textColor = .systemBackground
        label.font = .systemFont(ofSize: 18, weight: .medium)
        label.numberOfLines = 0
        label.textAlignment = .left
        // ImageView pushing down label after layout pass, making it one liner
        label.setContentCompressionResistancePriority(.required, for: .vertical)
        return label
    }()
    var toggleFavoriteButton: UIButton = {
        let button = UIButton()
        button.tintColor = .yellow
        button.widthAnchor.constraint(equalToConstant: 30).isActive = true
        return button
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setupViews() {
        toggleFavoriteButton.addTarget(
            self,
            action: #selector(toggleFavoriteButtonTapped),
            for: .touchUpInside
        )
        let detailStack = UIStackView(arrangedSubviews: [
            titleLabel,
            toggleFavoriteButton
        ])
        detailStack.axis = .horizontal
        detailStack.backgroundColor = .darkGray
        let detailMargin = 5.0
        detailStack.layoutMargins = UIEdgeInsets(
            top: detailMargin, 
            left: detailMargin,
            bottom: detailMargin,
            right: detailMargin
        )
        detailStack.isLayoutMarginsRelativeArrangement = true
        let stackView = UIStackView(arrangedSubviews: [
            posterImageView,
            detailStack
        ])
        stackView.axis = .vertical
        stackView.translatesAutoresizingMaskIntoConstraints = false
        let margin = 10.0
        stackView.layoutMargins = UIEdgeInsets(
            top: margin,
            left: margin,
            bottom: margin,
            right: margin
        )
        stackView.isLayoutMarginsRelativeArrangement = true
        contentView.addSubview(stackView)

        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            stackView.topAnchor.constraint(equalTo: contentView.topAnchor),
            stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }

    @objc
    func toggleFavoriteButtonTapped() {
        delegate?.toggleFavorite(for: self)
    }

    func bindFavoriteIcon(isFavorite: Bool) {
        toggleFavoriteButton.setImage(
            UIImage(systemName: isFavorite ? "heart.fill" : "heart"),
            for: .normal
        )
    }
}

protocol MovieCollectionViewCellDelegate: AnyObject {
    func toggleFavorite(for cell: MovieCollectionViewCell)
}
