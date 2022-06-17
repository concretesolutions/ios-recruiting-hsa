//
//  MoviesViewController.swift
//  MoviesApp
//
//  Created by gustavo.salazar on 17/06/22.
//

import UIKit

class MoviesViewController: UIViewController,MoviesPresenterDelegate {
   
    private var movie:[Movie] = []
    private let presenter = MoviesPresenter()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        presenter.setViewDelegate(delegate: self)
        presenter.getMovies(search: "")
    }
    
    func presentMovies(movies: [Movie]) {
        self.movie = movies
        
        DispatchQueue.main.async {
            //
        }
    }
    
    

}
