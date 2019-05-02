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
    
    weak var delegate: PopularMovieSelectionDelagate?
    private var movieId: Int?
    private var cellIndexPath: IndexPath?
    private var alreadyFavorited = false
    
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
        
        posterImageView.isUserInteractionEnabled = true
        let imageTapGesture = UITapGestureRecognizer(target: self, action: #selector(handleImageTapped(sender:)))
        posterImageView.addGestureRecognizer(imageTapGesture)
    }

    func setup(movie: SimpleMovieViewModel, cellIndexPath: IndexPath){
        titleLabel.text = movie.title
        alreadyFavorited = movie.isFavorited
        if(movie.isFavorited){
            favoriteIcon.image = UIImage(named: "favorite_full_icon")
        }else{
            favoriteIcon.image = UIImage(named: "favorite_gray_icon")
        }
        
        posterImageView.imageFromUrlWithAlamofire(urlString: NetworkConstants.baseImagesUrl + movie.posterPath)
        
        movieId = movie.movieId
        self.cellIndexPath = cellIndexPath
    }
    
    @objc
    func handleTap(sender: Any){
        guard let movieId = movieId,
            let cellIndexPath = cellIndexPath,
            let delegate = delegate else {return}
        if(!alreadyFavorited){
            alreadyFavorited = true
            delegate.favoriteIconTapped(movieId: movieId, at: cellIndexPath)
            favoriteIcon.image = UIImage(named: "favorite_full_icon")
        }
    }
    
    @objc
    func handleImageTapped(sender: Any){
        guard let movieId = movieId,
            let delegate = delegate else {return}
        delegate.moviePosterTapped(movieId: String(movieId))
        
    }
}
