//
//  MoviesAllCell.swift
//  InformationMovies
//
//  Created by Cristian Bahamondes on 25-06-22.
//

import UIKit

class MoviesAllCell: UITableViewCell {

    @IBOutlet weak var yearPeliculaLabe: UILabel!
    @IBOutlet weak var nombrePeliculaLabel: UILabel!
    @IBOutlet weak var DescripcionTextView: UITextView!
    @IBOutlet weak var imagenPeliculaImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
