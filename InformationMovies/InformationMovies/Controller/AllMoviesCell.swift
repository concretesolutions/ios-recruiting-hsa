//
//  AllMoviesCell.swift
//  InformationMovies
//
//  Created by Cristian Bahamondes on 25-06-22.
//

import UIKit

class AllMoviesCell: UITableViewCell {

    @IBOutlet weak var imageMovie: UIImageView!
    @IBOutlet weak var nameMovieLabel: UILabel!
    //@IBOutlet weak var descriptionTextView: UITextView!
    @IBOutlet weak var YearMovieLabel: UILabel!
    @IBOutlet weak var desciptionLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
