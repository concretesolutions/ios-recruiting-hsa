//
//  MovieDetailFeatureTableViewCell.swift
//  MovieScope
//
//  Created by Andrés Alexis Rivas Solorzano on 7/7/19.
//  Copyright © 2019 Andrés Alexis Rivas Solorzano. All rights reserved.
//

import UIKit

class MovieDetailFeatureTableViewCell: UITableViewCell {

    @IBOutlet weak var titleLb: UILabel!
    @IBOutlet weak var infoLb: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        contentView.backgroundColor = .appBackgroundColor
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    func updateInfo(item: MovieDetailFeatureModel){
        titleLb.text = item.title
        infoLb.text = item.info
    }
    
}
