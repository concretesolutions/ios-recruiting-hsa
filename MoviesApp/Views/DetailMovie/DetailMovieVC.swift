//
//  DetailMovieVC.swift
//  MoviesApp
//
//  Created by Hector Morales on 2/27/21.
//

import UIKit
import SDWebImage

class DetailMovieVC: UIViewController {

    @IBOutlet weak var bannerImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var yearLabel: UILabel!
    @IBOutlet weak var genresLabel: UILabel!
    @IBOutlet weak var overviewLabel: UILabel!
    @IBOutlet weak var favButton: UIButton!
    var movie: Movie!
    var presenter: DetailMoviePresenter?

    init (movie: Movie) {
        super.init(nibName: nil, bundle: nil)
        self.movie = movie
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        presenter = DetailMoviePresenter(movie: movie, dataSource: self)
    }

    @IBAction func backButtonTapped(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }


    @IBAction func favButtonTapped(_ sender: Any) {
        presenter?.saveMovieInFavorites()
    }
}

extension DetailMovieVC: DetailMoviePresenterProtocol {
    func gotMovieProtocol(movie: Movie) {
        bannerImageView.sd_setImage(with: movie.bannerURL)
        titleLabel.text = movie.title
        yearLabel.text = movie.year
        overviewLabel.text = movie.overview
        genresLabel.text = GenresHandler.getGenresById(genresId: movie.genreIDS)
        favButton.isSelected = movie.isFavorited
        if favButton.isSelected {favButton.isUserInteractionEnabled = false}
    }
    
    func movieSavedSuccessfully() {
        favButton.isSelected = true
    }

}
