//
//  CellTableViewCell.swift
//  movs
//
//  Created by Carlos Petit on 15-03-21.
//

import UIKit

class CellTableViewCell: UITableViewCell {

    @IBOutlet weak var imageViewCell: UIImageView!
    @IBOutlet weak var TitleViewCell: UILabel!
    @IBOutlet weak var YearViewCell: UILabel!
//    @IBOutlet weak var DescriptionViewCell: UITextView!
    @IBOutlet weak var DescriptionViewCell: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setUp(with movie: MovieViewModel, indexPath: Int){
        imageViewCell.load(url: movie.image)
        imageViewCell.contentMode = .scaleAspectFit
        TitleViewCell.text = movie.title
        DescriptionViewCell.text = movie.description
        YearViewCell.text = movie.year
    }

}
