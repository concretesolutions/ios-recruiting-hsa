//
//  FavoriteMovieCellVC.swift
//  concreteMoviesApp
//
//  Created by Nebraska Melendez on 7/25/19.
//  Copyright © 2019 Nebraska Melendez. All rights reserved.
//

import Foundation
import UIKit

protocol FavoriteMovieCellDelegate:class{
    func favoriteButtonTapped(in cell: FavoriteMovieCellVC)
}


class FavoriteMovieCellVC : UITableViewCell {
    
    @IBOutlet weak var moviePoster: UIImageView!
    @IBOutlet weak var movieTitle: UILabel!
    @IBOutlet weak var movieOverview: UILabel!
    @IBOutlet weak var movieDate: UILabel!
    @IBOutlet weak var favoriteButton: UIButton!
    
    
    weak var delegate:FavoriteMovieCellDelegate?

    //MARK: Life Cycle
    override func awakeFromNib() {
        super.awakeFromNib()
        
        setupView()
    }
    
    
    //MARK: Setups
    
    private func setupView(){
        
        self.separatorInset.left = 0
 
    }
    
    //MARK: Funcs
    @IBAction func favoriteButtonTapped(_ sender: Any) {
        
        delegate?.favoriteButtonTapped(in: self)
    }
    
}
