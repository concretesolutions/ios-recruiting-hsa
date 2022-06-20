//
//  MovieCollectionViewCell.swift
//  MoviesApp
//
//  Created by gustavo.salazar on 17/06/22.
//

import UIKit

//MARK: -  Movie
class MovieCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var poster: UIImageView!
    
    @IBOutlet weak var title: UILabel!
    
    @IBOutlet weak var favorite: UIImageView!
    
    func configurate(movie:Movie){
        title.text = movie.title
        poster.loadFrom(URLAddress: APIUrl.routeImage + (movie.poster_path))
        
        if movie.favorite == true {
            favorite.image = UIImage(named:"FavoriteFull")
            } else {
                favorite.image = UIImage(named: "FavoriteEmpty")
            }
    }
}
