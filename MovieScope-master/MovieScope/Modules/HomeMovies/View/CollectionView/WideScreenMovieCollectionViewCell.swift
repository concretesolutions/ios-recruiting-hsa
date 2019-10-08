//
//  WideScreenMovieCollectionViewCell.swift
//  MovieScope
//
//  Created by Andrés Alexis Rivas Solorzano on 7/5/19.
//  Copyright © 2019 Andrés Alexis Rivas Solorzano. All rights reserved.
//

import UIKit
import Nuke

class WideScreenMovieCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var shadowView: ShadowView!
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var titleLb: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        imgView.roundBorder(radius: 5.0)
    }
    
    func updateInfo(movie: MovieModel){
        titleLb.text = movie.title
        
        if let url = movie.getBackDropImageURL(withSize: .w1280){
            Nuke.loadImage(with: url, into: imgView)
        }
    }

}
