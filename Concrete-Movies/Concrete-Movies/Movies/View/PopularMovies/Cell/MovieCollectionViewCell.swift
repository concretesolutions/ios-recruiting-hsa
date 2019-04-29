//
//  MovieCollectionViewCell.swift
//  Concrete-Movies
//
//  Created by Audel Dugarte on 4/27/19.
//  Copyright © 2019 Audel Dugarte. All rights reserved.
//

import UIKit

class MovieCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var posterImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var favoriteIcon: UIImageView!
    @IBOutlet weak var textContainerView: UIView!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        
        prepareCell()
    }
    
    private func prepareCell(){
        favoriteIcon.isUserInteractionEnabled = true
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap(sender:)))
        favoriteIcon.addGestureRecognizer(tapGesture)
        
        backgroundColor = Colors.Primary.dark
        textContainerView.backgroundColor = Colors.Primary.dark
        titleLabel.textColor = Colors.Primary.brand
    }

    func setup(movie: SimpleMovieViewModel){
        titleLabel.text = movie.title
        if(movie.isFavorited){
            favoriteIcon.image = UIImage(named: "favorite_full_icon")
        }else{
            favoriteIcon.image = UIImage(named: "favorite_gray_icon")
        }
        
        //posterImageView.imageFromUrl(urlString: NetworkConstants.baseImagesUrl + movie.posterPath)
        posterImageView.imageFromUrlWithAlamofire(urlString: NetworkConstants.baseImagesUrl + movie.posterPath)
    }
    
    @objc
    func handleTap(sender: Any){
        print("tapped")
    }
}
