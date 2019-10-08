//
//  MovieMediaCollectionViewCell.swift
//  MovieScope
//
//  Created by Andrés Alexis Rivas Solorzano on 7/9/19.
//  Copyright © 2019 Andrés Alexis Rivas Solorzano. All rights reserved.
//

import UIKit
import Nuke

class MovieMediaCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var nameLb: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.contentView.backgroundColor = .appBackgroundColor
    }
    
    func updateInfo(movieItem: MovieModel){
    
        guard let url = movieItem.getPosterImageURL(withSize: .w300) else{
            displayErrorStyle(movieItem: movieItem)
            return
        }
        nameLb.isHidden = true
        
        let options = ImageLoadingOptions.init(placeholder: nil, transition: .fadeIn(duration: 0.17))
        
        Nuke.loadImage(with: url, options: options, into: imageView, progress: { (respone, _, _) in
         
            self.imageView.image = respone?.image
        
        }, completion: { response, error in
          
            if error != nil{
                self.displayErrorStyle(movieItem: movieItem)
            }else{
                self.imageView.contentMode = .scaleAspectFill
                self.imageView.image = response?.image
            }
       
        })
    }
    
    func displayErrorStyle(movieItem: MovieModel){
        
        nameLb.isHidden = false
        nameLb.text = movieItem.title
        imageView.image = .notFoundImage
        imageView.contentMode = .scaleAspectFit
    }
}
