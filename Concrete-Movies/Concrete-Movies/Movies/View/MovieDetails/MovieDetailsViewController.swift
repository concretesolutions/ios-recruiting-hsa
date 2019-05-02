//
//  MovieDetailsViewController.swift
//  Concrete-Movies
//
//  Created by Audel Dugarte on 4/28/19.
//  Copyright © 2019 Audel Dugarte. All rights reserved.
//

import UIKit

class MovieDetailsViewController: UIViewController {

    @IBOutlet weak var posterImageView: UIImageView!
    @IBOutlet weak var movieTitleLabel: UILabel!
    @IBOutlet weak var releaseDateLabel: UILabel!
    @IBOutlet weak var movieGenresLabel: UILabel!
    @IBOutlet weak var movieDescriptionLabel: UILabel!
    @IBOutlet weak var favoriteIndicatorIcon: UIImageView!
    
    var movieId: String?
    var isMovieFavorited = false
    var movieDetails: MovieDetailsViewModel?
    
    private var movieDetailsPresenter: MovieDetailsPresenter?
    
    let activityIndicator = UIActivityIndicatorView(style: .gray)
    
    convenience init(presenter: MovieDetailsPresenter){
        self.init()
        presenter.movieDetailsView = self
        self.movieDetailsPresenter = presenter
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        prepare()
    }

    private func prepare(){
        if let movieId = movieId{
            showActivityIndicator()
            movieDetailsPresenter?.fetchMovieDetails(movieId: movieId)
        }
        
        favoriteIndicatorIcon.isUserInteractionEnabled = true
        let imageTapGesture = UITapGestureRecognizer(target: self, action: #selector(favoriteIconTapped(sender:)))
        favoriteIndicatorIcon.addGestureRecognizer(imageTapGesture)
    }
    
    @objc
    private func favoriteIconTapped(sender: Any){
        guard let movieDetail = movieDetails else {return}
        if !isMovieFavorited{
            isMovieFavorited = true
            favoriteIndicatorIcon.image = UIImage(named: "favorite_full_icon")
            let favMovieVM = FavoritedMovieViewModel(
                name: movieDetail.title,
                movieId: movieDetail.movieId,
                overview: movieDetail.overview,
                posterPath: movieDetail.posterPath,
                releaseYear: movieDetail.releaseDate
            )
            movieDetailsPresenter?.saveFavorite(movie: favMovieVM)
        }
    }

    private func showActivityIndicator(){
        view.addSubview(activityIndicator)
        activityIndicator.frame = view.bounds
        activityIndicator.startAnimating()
    }
}

extension MovieDetailsViewController: MovieDetailsViewProtocol{
    func show(movie: MovieDetailsViewModel) {
        activityIndicator.removeFromSuperview()
        movieDetails = movie
        if let imagePath = movieDetails?.posterPath{
            posterImageView.imageFromUrlWithAlamofire(urlString: NetworkConstants.baseImagesUrl + imagePath)
        }
        movieTitleLabel.text = movieDetails?.title
        releaseDateLabel.text = movieDetails?.releaseDate
        movieDescriptionLabel.text = movieDetails?.overview
        movieGenresLabel.text = movieDetails?.genres.joined(separator: ", ")
        
        isMovieFavorited = movie.isFavorited
        if (movie.isFavorited){
            favoriteIndicatorIcon.image = UIImage(named: "favorite_full_icon")
        }else{
            favoriteIndicatorIcon.image = UIImage(named: "favorite_gray_icon")
        }
    }
    
    func show(error: Error) {
        activityIndicator.removeFromSuperview()
    }
    
    
}
