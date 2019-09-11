//
//  MovieDetailTextCell.swift
//  MovieDB
//
//  Created by Eddwin Paz on 9/7/19.
//  Copyright © 2019 acme dot inc. All rights reserved.
//

import UIKit

class MovieDetailTextCell: UITableViewCell {
    var viewModel: MovieCellRows! {
        didSet {
            rowText.text = viewModel.text
        }
    }

    let rowText: UILabel = {
        let label = UILabel()
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.5
        label.textColor = UIColor.black
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        label.frame = CGRect(x: 10, y: 105, width: 140, height: 50)
        label.textAlignment = .left
        return label
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        addSubview(rowText)
        let rowTextconstrains = [
            rowText.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            rowText.leftAnchor.constraint(equalTo: leftAnchor, constant: 20),
            rowText.rightAnchor.constraint(equalTo: rightAnchor, constant: -20),
            rowText.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10),
        ]
        NSLayoutConstraint.activate(rowTextconstrains)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        backgroundColor? = UIColor.white
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
