//
//  MovieDetailGenreCollectionViewCell.swift
//  MovieScope
//
//  Created by Andrés Alexis Rivas Solorzano on 7/7/19.
//  Copyright © 2019 Andrés Alexis Rivas Solorzano. All rights reserved.
//

import UIKit

class MovieDetailGenreCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var genreNameLb: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        enableAutoSizeWidth()
        genreNameLb.textColor = .white
        genreNameLb.font = UIFont.systemFont(ofSize: 14, weight: .regular)
    }
    
    func updateInfo(genreName: String){
        genreNameLb.text = genreName
    }
    
    //Normalmente las collectionview cell dependen del datasource para su tamaño, con este metodo activamos el autolayout para que esta celda escale su tamaño en base al tamaño de la label, la label a su vez se ajusta al texto
    func enableAutoSizeWidth(){
        contentView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            contentView.leftAnchor.constraint(equalTo: leftAnchor),
            contentView.rightAnchor.constraint(equalTo: rightAnchor),
            contentView.topAnchor.constraint(equalTo: topAnchor),
            contentView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }

}
