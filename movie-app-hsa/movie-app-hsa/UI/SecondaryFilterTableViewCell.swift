//
//  SecondaryFilterTableViewCell.swift
//  movie-app-hsa
//
//  Created by training on 04-07-22.
//

import UIKit

class SecondaryFilterTableViewCell: UITableViewCell {
    
    @IBOutlet weak var filterElementSecundaryLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
