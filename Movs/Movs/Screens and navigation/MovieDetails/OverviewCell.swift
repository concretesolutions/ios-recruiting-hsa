//
//  OverviewCell.swift
//  Movs
//
//  Created by Miguel Duran on 1/7/19.
//  Copyright © 2019 Miguel Duran. All rights reserved.
//

import UIKit

class OverviewCell: UITableViewCell {
    @IBOutlet private weak var overviewLabel: UILabel!

    var overview = String() {
        didSet {
            overviewLabel.text = overview
        }
    }
}
