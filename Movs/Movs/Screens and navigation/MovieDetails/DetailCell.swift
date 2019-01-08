//
//  TextCell.swift
//  Movs
//
//  Created by Miguel Duran on 1/7/19.
//  Copyright © 2019 Miguel Duran. All rights reserved.
//

import UIKit

class DetailCell: UITableViewCell {
    @IBOutlet private weak var detailLabel: UILabel!
    
    var detail = String() {
        didSet {
            detailLabel.text = detail
        }
    }
}
