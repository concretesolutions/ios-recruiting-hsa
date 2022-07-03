//
//  ItemFavTableViewCell.swift
//  iOS-movieApp
//
//  Created by alvaro.concha on 30-06-22.
//

import UIKit

class ItemFavTableViewCell: UITableViewCell {
    
    @IBOutlet weak var pictureMovieImageView : UIImageView!
    @IBOutlet weak var titleMovieLabel : UILabel!
    @IBOutlet weak var anioMovieLabel : UILabel!
    @IBOutlet weak var desciptionTextView : UITextView!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
