//
//  FavoriteTableViewCell.swift
//  Movs
//
//  Created by Jose Antonio Aravena on 9/3/19.
//  Copyright © 2019 Jose Antonio Aravena. All rights reserved.
//

import UIKit

class FavoriteTableViewCell: UITableViewCell {

    @IBOutlet weak var movieImage: UIImageView!
    @IBOutlet weak var titulo: UILabel!
    @IBOutlet weak var resumen: UILabel!
    @IBOutlet weak var año: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
