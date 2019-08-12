//
//  LabelTableViewCell.swift
//  ios-recruiting-hsa
//
//  Created on 11-08-19.
//

import UIKit

class LabelTableViewCell: UITableViewCell {
    @IBOutlet
    private weak var movieLabel: UILabel!
    private var separator: UIView!
    @IBOutlet
    fileprivate weak var favoriteImageView: UIImageView!
    @IBOutlet
    private weak var favoriteImageViewWidth: NSLayoutConstraint!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        prepareViews()
    }
    
    private func prepareViews() {
        movieLabel.numberOfLines = Constants.Text.noLinesLimit
        selectionStyle = .none
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        if (separator != nil) {
            separator.frame = DetailConstants.Cells.separatorFrame(width: bounds.size.width)
        }
    }
    
    func configure(title: String,
                   showSeparator: Bool,
                   showFavorite: Bool = false
    ) {
        movieLabel.text = title
        
        if (showSeparator) {
            separator = UIView()
            separator.backgroundColor = .lightGray
            contentView.addSubview(separator)
        }
        
        favoriteImageViewWidth.constant = showFavorite ? DetailConstants.Cells.Label.width : 0
    }
    
    override func prepareForReuse() {
        movieLabel.text = nil
    }
}

extension LabelTableViewCell: FavoriteDelegate {
    func markFavorite() {
        favoriteImageView.image = UIImage(named: "favorite_full_icon")
    }
}
