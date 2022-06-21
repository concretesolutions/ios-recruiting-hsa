//
//  FilterTableViewCell.swift
//  MoviesApp
//
//  Created by gustavo.salazar on 20/06/22.
//

import UIKit

class FilterTableViewCell: UITableViewCell {

    @IBOutlet weak var optionLabel: UILabel!
    @IBOutlet weak var resultLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func setConfigurate(option:Option){
        optionLabel.text = option.option.rawValue
        resultLabel.text = option.result
    }
}
