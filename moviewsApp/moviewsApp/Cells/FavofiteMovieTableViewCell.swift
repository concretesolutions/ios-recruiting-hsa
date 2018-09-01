//
//  FavofiteMovieTableViewCell.swift
//  moviewsApp
//
//  Created by carlos jaramillo on 8/21/18.
//  Copyright © 2018 carlos jaramillo. All rights reserved.
//

import UIKit

class FavofiteMovieTableViewCell: UITableViewCell {

    @IBOutlet weak var posterImage: UIImageView!
    @IBOutlet weak var yearLabel: UILabel!
    @IBOutlet weak var overviewLabel: UITextView!
    @IBOutlet weak var titleLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
