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
    var movieDetails: MovieDetailsViewModel?
    
    private var movieDetailsPresenter: MovieDetailsPresenter?
    
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
            movieDetailsPresenter?.fetchMovieDetails(movieId: movieId)
        }
    }

}

extension MovieDetailsViewController: MovieDetailsViewProtocol{
    func show(movie: MovieDetailsViewModel) {
        movieDetails = movie
        if let imagePath = movieDetails?.posterPath{
            posterImageView.imageFromUrlWithAlamofire(urlString: NetworkConstants.baseImagesUrl + imagePath)
        }
        movieTitleLabel.text = movieDetails?.title
        releaseDateLabel.text = movieDetails?.releaseDate
        movieDescriptionLabel.text = movieDetails?.overview
        movieGenresLabel.text = movieDetails?.genres.joined(separator: ", ")
    }
    
    func show(error: Error) {
        //show error
    }
    
    
}
