//
//  MovieCollectionViewCell.swift
//  Movs
//
//  Created by Jose Antonio Aravena on 9/3/19.
//  Copyright © 2019 Jose Antonio Aravena. All rights reserved.
//

import UIKit

class MovieCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var favButton: UIButton!
    var isFavorite = false
    @IBOutlet weak var movieImage: UIImageView!
    @IBOutlet weak var titulo: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        movieImage.addConstraint(movieImage.widthAnchor.constraint(equalToConstant: self.bounds.width))
        movieImage.addConstraint(movieImage.heightAnchor.constraint(equalToConstant: self.bounds.height))
        
    }

    func inicializarCelda(pelicula:Pelicula){
        self.titulo.text = pelicula.titulo
        self.isFavorite = pelicula.favorito
        cambiaBoton()
    }
    @IBAction func addToFavorites(_ sender: Any) {
        cambiaBoton()
        self.isFavorite =  !self.isFavorite
    }
    
    func cambiaBoton(){
        if !isFavorite{
            favButton.setImage(UIImage(named: "b1"), for: .normal)
        }
        else{
            favButton.setImage(UIImage(named: "b2"), for: .normal)
        }
    }
}
