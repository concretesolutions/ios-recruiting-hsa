//
//  FavoriteTableViewCell.swift
//  GetMovieApp
//
//  Created by Training on 03-07-22.
//

import UIKit

class FavoriteTableViewCell: UITableViewCell {
    
    //MARK: Oulets
    @IBOutlet weak var movieImageSelect: UIImageView!
    @IBOutlet weak var nameMovieLabel: UILabel!
    @IBOutlet weak var yearMovieLabel: UILabel!
    @IBOutlet weak var descriptionMovieLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
