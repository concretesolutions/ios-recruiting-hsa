//
//  MovieCollectionViewCell.swift
//  concreteIOSRecruitChallenge
//
//  Created by Kristian Sthefan Cortes Prieto on 08-02-21.
//

import UIKit

class MovieCollectionViewCell: UICollectionViewCell {
    
    var viewModel: MoviesViewModel?
    var movieEntry: MovieEntry?
    var favoriteImageView : UIImageView?
    var delegate: MoviesViewControllerProtocol?

    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func loadCellView(movieEntry: MovieEntry?, viewModel: MoviesViewModel?, delegate: MoviesViewControllerProtocol?){
        let titleLabel : UILabel = viewWithTag(2) as! UILabel
        let photoImageView : UIImageView = viewWithTag(1) as! UIImageView
        let activityIndicatorView : UIActivityIndicatorView = viewWithTag(3) as! UIActivityIndicatorView
        let favoriteButton : UIButton = viewWithTag(4) as! UIButton
        self.favoriteImageView = viewWithTag(5) as? UIImageView
        
        self.viewModel = viewModel
        self.movieEntry = movieEntry
        self.delegate = delegate
        
        if let movieId = self.movieEntry?.id {
            if(self.viewModel?.isFavorite(id: movieId) == true) {
                self.favoriteImageView?.image = #imageLiteral(resourceName: "favorite_full_icon")
            } else {
                self.favoriteImageView?.image = #imageLiteral(resourceName: "favorite_gray_icon")
            }
        }
        
        titleLabel.text = movieEntry?.title
        if let poster = movieEntry?.poster_path { photoImageView.loadFromUrl(url: "\(Constants.imageEndpoint)/t/p/w300/\(poster)", activityIndicator: activityIndicatorView, errorImage: #imageLiteral(resourceName: "empty_photo")) }
        
        favoriteButton.addTarget(self, action: #selector(self.favoriteButtonPress(sender:)), for: .touchUpInside)
    }
    
    @IBAction func favoriteButtonPress(sender: UIButton) {
        if let movieId = self.movieEntry?.id {
            if (self.viewModel?.isFavorite(id: movieId) == true){
                _ = self.viewModel?.removeFavorite(id: movieId)
                self.favoriteImageView?.image = #imageLiteral(resourceName: "favorite_gray_icon")
            }else{
                if let movie = self.movieEntry {
                    self.viewModel?.addFavorite(movie: movie)
                    self.favoriteImageView?.image = #imageLiteral(resourceName: "favorite_full_icon")
                }
            }
            self.delegate?.reloadFavoriteList()
        }
    }
}
