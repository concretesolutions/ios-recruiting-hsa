//
//  FavoritosTableViewCell.swift
//  proyMovieDB
//
//  Created by Tabata Céspedes Figueroa on 07-06-23.
//

import UIKit

class FavoritosTableViewCell: UITableViewCell {

    @IBOutlet weak var imagenPeliculaView: UIImageView!
    @IBOutlet weak var tituloPelicula: UILabel!
    @IBOutlet weak var anioPelicula: UILabel!
    @IBOutlet weak var descripcionPelicula: UITextView!
    @IBOutlet weak var generosPelicula: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
