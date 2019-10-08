//
//  MinimalMovieCollectionViewCell.swift
//  MovieScope
//
//  Created by Andrés Alexis Rivas Solorzano on 7/3/19.
//  Copyright © 2019 Andrés Alexis Rivas Solorzano. All rights reserved.
//

import UIKit
import Nuke

class MinimalMovieCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var title: UILabel!
    
    override var isHighlighted: Bool {
        didSet {
            animateCellHighLight(shrink: isHighlighted)
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        imgView.roundBorder(radius: 5.0)
    }

    func updateInfo(movieItem: MovieModel){
        title.text = movieItem.title
        
        if let url = movieItem.getBackDropImageURL(withSize: .w300){
            Nuke.loadImage(with: url, into: imgView)
        }
    }
    

    private func animateCellHighLight(shrink: Bool){
     
        let transformScale = shrink ? CGAffineTransform(scaleX: 0.90, y: 0.90) : CGAffineTransform.identity
        
        UIView.animate(withDuration: 0.2, delay: 0, options: .curveEaseOut, animations: {
            self.transform = transformScale
        }, completion: nil)
        
    }
    
}
