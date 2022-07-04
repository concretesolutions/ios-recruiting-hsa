//
//  MovieCollectionViewCell.swift
//  movie-app-hsa
//
//  Created by training on 03-07-22.
//

import UIKit

class MovieCollectionViewCell: UICollectionViewCell {
    
    var imageSelected: Bool = false
    
    var id: Int = 0
    var name: String = ""
    var releaseDate: String = ""
    var synopsis: String = "";
    var image: String = "";
    
    let favouriteManager = FavouriteManager.shared

    @IBOutlet weak var photoMovieImageView: UIImageView!
    @IBOutlet weak var nameMovieLabel: UILabel!
    @IBOutlet weak var favouriteButton: UIButton!

    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    @IBAction func movieSelectedButton(_ sender: Any) {
        
        if imageSelected {
            if let favouriteImage = UIImage(systemName: "heart") {
                self.favouriteButton.setImage(favouriteImage, for: .normal)
                imageSelected = false
                let favourite: Favourite = Favourite(id: id, name: name, image: image, releaseDate: releaseDate, synopsis: synopsis)
                favouriteManager.remove(favourite: favourite)
                
            }
        } else {
            if let favouriteImage = UIImage(systemName: "heart.fill") {
                self.favouriteButton.setImage(favouriteImage, for: .normal)
                imageSelected = true
                let favourite: Favourite = Favourite(id: id, name: name, image: image, releaseDate: releaseDate, synopsis: synopsis)
                favouriteManager.add(favourite: favourite)
            }
            
        }
        favouriteManager.favoriteChangeOff()
        favouriteManager.lists()
    }

}
