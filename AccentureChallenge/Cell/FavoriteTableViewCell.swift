//
//  FavoriteTableViewCell.swift
//  AccentureChallenge
//
//  Created by Jaime on 2/4/19.
//  Copyright © 2019 Jaime. All rights reserved.
//

import UIKit

class FavoriteTableViewCell: UITableViewCell {
    
    @IBOutlet weak var pictureImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    var movie: Movie! {
        didSet{
            
            titleLabel.text = movie.name
            let url = URL(string: movie.pictureURL)
            pictureImageView.kf.setImage(with: url!)
            
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy"
            dateLabel.text = dateFormatter.string(from: movie.date)
            
            descriptionLabel.text = movie.movieDescription
            
        }
    }
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }


}
