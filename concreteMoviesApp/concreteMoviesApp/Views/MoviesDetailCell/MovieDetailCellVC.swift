//
//  MovieDetailCell.swift
//  concreteMoviesApp
//
//  Created by Nebraska Melendez on 7/27/19.
//  Copyright © 2019 Nebraska Melendez. All rights reserved.
//

import Foundation
import UIKit

protocol MovieDetailCellDelegate:class{
    func favoriteButtonTapped(in cell: MovieDetailCellVC)
}

class MovieDetailCellVC : UITableViewCell {
    
    //MARK: UIVars
    
    @IBOutlet weak var movieTitle: UILabel!
    @IBOutlet weak var movieGenre: UILabel!
    @IBOutlet weak var movieDate: UILabel!
    @IBOutlet weak var movieDetail: UILabel!
    @IBOutlet weak var favoriteButton: UIButton!
    
    weak var delegate:MovieDetailCellDelegate?

    
    //MARK: Life Cycle
    override func awakeFromNib() {
        super.awakeFromNib()
    
    }
    
    
    //MARK: Funcs
    
    @IBAction func favoriteButtonTapped(_ sender: Any) {
        
            delegate?.favoriteButtonTapped(in: self)
    }
    
}
