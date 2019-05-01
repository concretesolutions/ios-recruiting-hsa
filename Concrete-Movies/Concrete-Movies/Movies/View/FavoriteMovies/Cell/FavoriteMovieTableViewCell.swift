//
//  FavoriteMovieTableViewCell.swift
//  Concrete-Movies
//
//  Created by Audel Dugarte on 5/1/19.
//  Copyright © 2019 Audel Dugarte. All rights reserved.
//

import UIKit

class FavoriteMovieTableViewCell: UITableViewCell {
    
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var posterImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var releaseDateLabel: UILabel!
    @IBOutlet weak var overviewtext: UITextView!
    
    weak var delegate: FavoriteMovieSelectionDelagate?
    
    private var movieId: Int?

    override func awakeFromNib() {
        super.awakeFromNib()
        
        prepare()
    }
    
    private func prepare(){
        containerView.backgroundColor = Colors.Primary.dark
        overviewtext.backgroundColor = Colors.Primary.dark
        
        isUserInteractionEnabled = true
        let cellTapGesture = UITapGestureRecognizer(target: self, action: #selector(handleCellTapped(sender:)))
        addGestureRecognizer(cellTapGesture)
        let textTapGesture = UITapGestureRecognizer(target: self, action: #selector(handleCellTapped(sender:)))
        overviewtext.addGestureRecognizer(textTapGesture)
    }
    
    func setup(movie: FavoritedMovieViewModel){
        posterImageView.imageFromUrlWithAlamofire(urlString: NetworkConstants.baseImagesUrl + movie.posterPath)
        
        titleLabel.text = movie.name
        releaseDateLabel.text = movie.releaseYear
        overviewtext.text = movie.overview
        
        movieId = movie.movieId
    }
    
    @objc
    private func handleCellTapped(sender: Any){
        guard let movieId = movieId,
            let delegate = delegate else {return}
        delegate.movieCellTapped(movieId: String(movieId))
    }
    
}
