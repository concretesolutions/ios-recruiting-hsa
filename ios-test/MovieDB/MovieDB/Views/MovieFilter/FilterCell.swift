//
//  FilterCell.swift
//  MovieDB
//
//  Created by Eddwin Paz on 9/8/19.
//  Copyright © 2019 acme dot inc. All rights reserved.
//

import UIKit

class FilterCell: UITableViewCell {
    var model: FilterRows! {
        didSet {
            titleLabel.text = model.title
            valueLabel.text = model.value
        }
    }

    let titleLabel: UILabel = {
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

    let valueLabel: UILabel = {
        let label = UILabel()
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.5
        label.textColor = UIColor.black
        label.numberOfLines = 0
        label.textColor = UIColor(red: 0.967, green: 0.806, blue: 0.357, alpha: 1.0)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.frame = CGRect(x: 10, y: 105, width: 140, height: 50)
        label.textAlignment = .left
        return label
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        accessoryType = .disclosureIndicator

        addSubview(titleLabel)
        addSubview(valueLabel)

        let titleLabelconstrains = [
            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            titleLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 20),
        ]
        NSLayoutConstraint.activate(titleLabelconstrains)

        let valueLabelconstrains = [
            valueLabel.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            valueLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: -40),
        ]
        NSLayoutConstraint.activate(valueLabelconstrains)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        backgroundColor? = UIColor.white
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
