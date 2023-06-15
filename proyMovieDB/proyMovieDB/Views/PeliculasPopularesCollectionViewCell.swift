//
//  PeliculasPopularesCollectionViewCell.swift
//  proyMovieDB
//
//  Created by Tabata Céspedes Figueroa on 04-06-23.
//

import UIKit

class PeliculasPopularesCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var tituloPeliculaView: UILabel!
    @IBOutlet weak var imagenPeliculaView: UIImageView!
    @IBOutlet weak var iconoFavoritoView: UIImageView!
    @IBOutlet weak var iconoFavoritoMarcado: UIImageView!
    
    func llenar(peli: DataResult) {
        tituloPeliculaView.text = peli.title
    }
}

