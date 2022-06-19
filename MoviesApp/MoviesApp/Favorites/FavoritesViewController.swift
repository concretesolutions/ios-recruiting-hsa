//
//  FavoritesViewController.swift
//  MoviesApp
//
//  Created by gustavo.salazar on 17/06/22.
//

import UIKit

//MARK: - 
class FavoritesViewController: UIViewController ,FavoritesPresenterDelegate{
  
    var presenter: FavoritesPresenter = FavoritesPresenter()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        presenter.setViewDelegate(delegate: self)
        presenter.getFavorites()
    }
    
    func presentMoviesFavorites(movies: [MovieDB]) {
       
    }
    
}
