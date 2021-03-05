//
//  MovieDetailController.swift
//  Movies
//
//  Created by Daniel Nunez on 03-03-21.
//

import UIKit
import SDWebImage

protocol MovieDetailProtocol: class {
    func fill(_ movie: Movie)
    func saved()
}

class MovieDetailController: UIViewController, MovieDetailProtocol {

    @IBOutlet weak var imgMovie: UIImageView!
    @IBOutlet weak var navBar: UINavigationItem!
    @IBOutlet weak var btnFavorite: UIBarButtonItem!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblYear: UILabel!
    @IBOutlet weak var lblGenres: UILabel!
    @IBOutlet weak var lblDesc: UILabel!

    weak var coordinator: MainCoordinator?
    var presenter: MovieDetailPresenter?
    var movie: Movie!

    // MARK: Lyfecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        
        presenter?.load()
    }

    func setupFavorite() {
        if movie.isFavorite {
            btnFavorite.image = #imageLiteral(resourceName: "favorite_full_icon.png")
        } else { btnFavorite.image = #imageLiteral(resourceName: "favorite_empty_icon.png") }
    }

    // MARK: Protocol

    func fill(_ movie: Movie) {
        self.movie = movie
        imgMovie.sd_setImage(with: movie.imgURL)
        navBar.title = movie.title
        lblTitle.text = movie.title
        //        lblGenres.text = movie.genreIDS
        lblDesc.text = movie.overview
        setupFavorite()
    }

    func saved() {
        movie.isFavorite = true
        setupFavorite()
    }


    // MARK: Actions

    @IBAction func back(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
}
