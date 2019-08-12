//
//  FavoriteTableViewCell.swift
//  ios-recruiting-hsa
//
//  Created on 8/12/19.
//

import UIKit

class FavoriteTableViewCell: UITableViewCell {
    @IBOutlet
    private weak var movieImageView: UIImageView!
    @IBOutlet
    private weak var titleLabel: UILabel!
    @IBOutlet
    private weak var yearLabel: UILabel!
    @IBOutlet
    private weak var overviewLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        prepareViews()
    }
    
    private func prepareViews() {
        movieImageView.contentMode = .scaleToFill
        contentView.backgroundColor = Constants.Colors.lightGray
        titleLabel.numberOfLines = Constants.Text.noLinesLimit
        titleLabel.font = UIFont.boldSystemFont(ofSize: titleLabel.font.pointSize - 2)
        yearLabel.numberOfLines = Constants.Text.noLinesLimit
        yearLabel.font = UIFont.systemFont(ofSize: yearLabel.font.pointSize - 2)
        overviewLabel.numberOfLines = Constants.Text.fiveLinesLimit
        overviewLabel.font = UIFont.systemFont(ofSize: overviewLabel.font.pointSize - 3)
        selectionStyle = .none
    }
    
    func configure(imageUrl: String?,
                   title: String,
                   year: String,
                   overview: String
    ) {
        if let imageUrl = imageUrl, !imageUrl.isEmpty, let url = URL(string: imageUrl) {
            movieImageView.af_setImage(withURL: url)
        }
        titleLabel.text = title
        yearLabel.text = year
        overviewLabel.text = overview
    }
    
    override func prepareForReuse() {
        movieImageView.image = UIImage(named: "placeholder")
        titleLabel.text = nil
        yearLabel.text = nil
        overviewLabel.text = nil
    }
}
