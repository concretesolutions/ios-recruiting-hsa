//
//  DetailMovieViewController.swift
//  MoviesApp
//
//  Created by gustavo.salazar on 17/06/22.
//

import UIKit

//MARK: - Detail of View Movie Controller
class DetailMovieViewController: UIViewController,DetailMoviePresenterDelegate {
    @IBOutlet weak var posterImagen: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var favoriteImage: UIImageView!
    @IBOutlet weak var yearLabel: UILabel!
    @IBOutlet weak var sinopsisLabel: UITextView!
    @IBOutlet weak var generoLabel: UILabel!
    var movie: Movie? = nil
    let presenter: DetailMoviePresenter = DetailMoviePresenter()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.setViewDelegate(delegate: self)
        presenter.getGenres(genreIDS: movie!.genre_ids)
        setConfigure()
    }
    
    func setConfigure(){
        posterImagen.loadFrom(URLAddress: APIUrl.routeImage + (movie!.poster_path))
        titleLabel.text = movie?.title
        yearLabel.text = movie?.formatDate()
        generoLabel.text = ""
        sinopsisLabel.text = movie?.overview
    }
    
    func presentGender(gender: String) {
        DispatchQueue.main.async {
            self.generoLabel.text = gender
        }
    }
    
    func showError(error: Error) {
        AlertMovie.showBasicAlert(in:self, title: AlertConstant.Error, message: error.localizedDescription)
    }


}
