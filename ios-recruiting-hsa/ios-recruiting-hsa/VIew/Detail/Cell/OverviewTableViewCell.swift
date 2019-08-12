//
//  OverviewTableViewCell.swift
//  ios-recruiting-hsa
//
//  Created on 11-08-19.
//

import UIKit

class OverviewTableViewCell: UITableViewCell {
    @IBOutlet
    private weak var movieLabel: UILabel!
    private var separator: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        prepareViews()
    }

    private func prepareViews() {
        movieLabel.numberOfLines = Constants.Text.noLinesLimit
        movieLabel.font = UIFont.systemFont(ofSize: movieLabel.font.pointSize - 2)
        selectionStyle = .none
        separator = UIView()
        separator.backgroundColor = .lightGray
        contentView.addSubview(separator)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        separator.frame = DetailConstants.Cells.separatorFrame(width: bounds.size.width)
    }
    
    func configure(title: String) {
        movieLabel.text = title
    }
    
    override func prepareForReuse() {
        movieLabel.text = nil
    }
}
