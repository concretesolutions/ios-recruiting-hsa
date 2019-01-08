//
//  PosterCell.swift
//  Movs
//
//  Created by Miguel Duran on 1/7/19.
//  Copyright © 2019 Miguel Duran. All rights reserved.
//

import UIKit

class PosterCell: UITableViewCell {
    @IBOutlet private weak var posterImageView: UIImageView!

    var poster = UIImage() {
        didSet {
            posterImageView.image = poster
        }
    }
}
