//
//  MovieCell.swift
//  TestProject
//
//  Created by Felipe S Vergara on 21-10-18.
//  Copyright © 2018 MyOwnCompany. All rights reserved.
//

import UIKit
import Kingfisher

protocol MovieCellDelegate{
    func addFavEvent(movie:Movie)
    func removeFavEvent(movie:Movie)
}

class MovieCell: UICollectionViewCell {
    
    @IBOutlet weak var posterImage: UIImageView!
    @IBOutlet weak var favButton: UIButton!
    //isFavorite?
    var isFav:Bool = false
    //delegate
    var delegate: MovieCellDelegate?
    //Waiting to receive data
    var favoriteList : [Movie]?{
        didSet{
            render()
        }
    }
    //Waiting to receive data
    var movie : Movie?{
        didSet{
            render()
        }
    }
    
    
    func render() {
        //start false always
        isFav = false
        //favoriteButton type unfavorite
        favButton.favoriteType(show: false)
        if let mov = movie{
            posterImage.kf.setImage(with: mov.getUrlImage())
            if let fav = favoriteList{
                for favorite in fav{
                    if favorite.id == mov.id{
                        favButton.favoriteType(show: true)
                        isFav = true
                        return
                    }
                }
            }
            
        }
    }
    
    //We send an event by delegates (protocols)
    @IBAction func addFav(_ sender: Any) {
        if let mov = movie{
            isFav ? self.delegate?.removeFavEvent(movie: mov) : self.delegate?.addFavEvent(movie: mov)
        }
    }
}


