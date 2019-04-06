//
//  DetailTableViewCell.swift
//  MovieApp
//
//  Created by Sebastian Diaz on 4/5/19.
//  Copyright © 2019 Accenture. All rights reserved.
//

import UIKit

class DetailTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var favoriteImage: UIImageView!
    

    override func awakeFromNib() {
        super.awakeFromNib()
   
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    
    func hideIconFavorite(){
        self.favoriteImage.isHidden = true
    }
    
    func showIconFavorite(){
        self.favoriteImage.isHidden = false
    }
}
