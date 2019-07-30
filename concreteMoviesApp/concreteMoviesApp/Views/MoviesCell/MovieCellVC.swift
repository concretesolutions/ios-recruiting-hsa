//
//  MovieCellVC.swift
//  concreteMoviesApp
//
//  Created by Nebraska Melendez on 7/26/19.
//  Copyright © 2019 Nebraska Melendez. All rights reserved.
//

import UIKit


protocol MovieCellDelegate: class{
    func favoriteButtonTapped(in cell: MovieCellVC)
}

class MovieCellVC: UICollectionViewCell {
    
    @IBOutlet weak var moviePoster: UIImageView!
    @IBOutlet weak var movieTitle: UILabel!
    @IBOutlet weak var favoriteButton: UIButton!
    
    weak var delegate:MovieCellDelegate?
    
    @IBAction func favoriteButtonTapped(_ sender: Any) {
        self.delegate?.favoriteButtonTapped(in: self)
    }
    
}

