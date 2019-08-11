//
//  MovieCollectionViewCell.swift
//  ios-recruiting-hsa
//
//  Created on 10-08-19.
//

import AlamofireImage

class MovieCollectionViewCell: UICollectionViewCell {
    @IBOutlet
    private weak var imageView: UIImageView!
    @IBOutlet
    private weak var containerView: UIView!
    @IBOutlet
    private weak var movieLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        prepareViews()
    }
    
    private func prepareViews() {
        imageView.contentMode = .scaleToFill
        containerView.backgroundColor = Constants.Colors.dark
        movieLabel.numberOfLines = Constants.Text.numberOfLines
        movieLabel.adjustsFontSizeToFitWidth = true
        movieLabel.minimumScaleFactor = Constants.Text.minimumScale
        movieLabel.textColor = Constants.Colors.accent
        movieLabel.font = UIFont.boldSystemFont(ofSize: movieLabel.font.pointSize)
        movieLabel.textAlignment = .center
    }
    
    func configure(imageUrl: String?,
                   name: String
    ) {
        if let imageUrl = imageUrl, let url = URL(string: imageUrl) {
            imageView.af_setImage(withURL: url)
        }
        movieLabel.text = name
    }
    
    override func prepareForReuse() {
        imageView.image = UIImage(named: "placeholder")
        movieLabel.text = nil
    }
}
