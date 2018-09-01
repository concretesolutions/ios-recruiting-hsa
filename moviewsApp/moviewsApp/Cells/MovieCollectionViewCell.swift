//
//  MovieCollectionViewCell.swift
//  moviewsApp
//
//  Created by carlos jaramillo on 8/31/18.
//  Copyright © 2018 carlos jaramillo. All rights reserved.
//

import UIKit

protocol MovieCollectionCellDelegate : class {
    func didAddFavorites(indexPath : IndexPath)
    func didremoveFavorites(indexPath : IndexPath)
}

class MovieCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var moviePoster: UIImageView!
    @IBOutlet weak var nameMovie: UILabel!
    @IBOutlet weak var likeButton: UIButton!
    
    weak var delegate : MovieCollectionCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        let image = #imageLiteral(resourceName: "favorite").withRenderingMode(.alwaysTemplate)
        self.likeButton.setImage(image, for: .normal)
    }
    
    override func prepareForReuse() {
        self.moviePoster.image = nil
        self.nameMovie.text = ""
    }
    
    @IBAction func tapHeart(_ sender: UIButton) {
        guard let collection = self.superview as? UICollectionView else {
            return
        }
        guard let indexPath = collection.indexPath(for: self) else {
            return
        }
        if self.likeButton.tintColor == .white{
            self.delegate?.didAddFavorites(indexPath: indexPath)
        }
        else{
            self.delegate?.didremoveFavorites(indexPath: indexPath)
        }
    }
}

