//
//  MovieCollectionViewCell.swift
//  ConcreteIOsRecruit
//
//  Created by Matías Contreras Selman on 11/19/18.
//  Copyright © 2018 Matias Contreras. All rights reserved.
//

import UIKit
import Kingfisher

protocol MovieCollectionViewCellDelegate{
    func didTapFavIcon(cell: UICollectionViewCell)
}

class MovieCollectionViewCell: UICollectionViewCell {
    var delegate : MovieCollectionViewCellDelegate? = nil //we add the protocol just in case we need to pass any other actions to the delegate
    
    @IBOutlet weak var favButton: UIButton!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var title: UILabel!

    var movie: Movie? = nil { //there is no need to create a movieViewModel for this as there is not much logic in here
        didSet{
            if let movie = movie{
                self.title.text = movie.title
                imageView.kf.setImage(with: URL(string: movie.fullImageUrl))
                updateFavIcon()
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    @IBAction func tapFavIcon(_ sender: Any) {
        self.movie?.isFavorite = true
        //add the movie to favorites
        updateFavIcon()
        
        delegate?.didTapFavIcon(cell: self) //pass the action to the delegate in case we need to perform any other action
    }
    
    func updateFavIcon(){
        if let movie = movie{ //this state swap should be done using an indivisual component... but its not worth just for the sake of this example
            if movie.isFavorite{
                let favIconOff = UIImage(named: "favorite_full_icon")
                
                favButton.setImage(favIconOff, for: .normal)
            }
            else{
                let favIconOn = UIImage(named: "favorite_gray_icon")
                favButton.setImage(favIconOn, for: .normal)
            }
        }
    }
}
