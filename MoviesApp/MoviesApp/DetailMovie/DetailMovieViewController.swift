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
    @IBOutlet weak var favoriteButton: UIButton!
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
    
    func setFavorite(){
        if movie?.favorite == true {
            favoriteButton.setImage(UIImage(named:"FavoriteFull"), for: .normal)
            } else {
                favoriteButton.setImage(UIImage(named: "FavoriteEmpty"), for: .normal)
            }
    }
    
    func setConfigure(){
        posterImagen.loadFrom(URLAddress: APIUrl.routeImage + (movie!.poster_path))
        titleLabel.text = movie?.title
        yearLabel.text = movie?.getYear()
        generoLabel.text = ""
        sinopsisLabel.text = movie?.overview
        setFavorite()
    }
    
    func presentGender(gender: String) {
        DispatchQueue.main.async {
            self.movie?.genre = gender
            self.generoLabel.text = gender
        }
    }
    
    func showError(error: Error) {
        AlertMovie.showBasicAlert(in:self, title: AlertConstant.Error, message: error.localizedDescription)
    }

    @IBAction func touchFavorite(_ sender: Any) {
        
            self.presenter.saveFavorite(movie: self.movie!)
        
    }
    
    func showFavorite() {
       
        AlertMovie.showBasicAlert(in:self, title: AlertConstant.Error, message: "Favorito Agregado")
       
    }
    
  
}
