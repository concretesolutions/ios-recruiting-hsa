//
//  EmptyMoviesCollectionViewCell.swift
//  Concrete-Movies
//
//  Created by Audel Dugarte on 5/2/19.
//  Copyright © 2019 Audel Dugarte. All rights reserved.
//

import UIKit

class EmptyMoviesCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        prepare()
    }

    private func prepare(){
        iconImageView.image = UIImage(named: "favorite_empty_icon")
        descriptionLabel.text = "You have no favorite movies yet"
    }
    
    func setup(searchFailed: Bool){
        if searchFailed{
            iconImageView.image = UIImage(named: "search_icon")
            descriptionLabel.text = "Your search did not return results"
        }
    }
}
