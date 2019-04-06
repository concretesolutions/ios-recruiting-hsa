//
//  DetailViewController.swift
//  MovieApp
//
//  Created by Sebastian Diaz on 4/5/19.
//  Copyright © 2019 Accenture. All rights reserved.
//

import UIKit

protocol MovieDetailViewProtocol {
    func showDetailMovie(movie : MovieViewModel)
}

class MovieDetailViewController: UIViewController {
    
    var presenter  : MovieDetailPresenter?

    override func viewDidLoad() {
        super.viewDidLoad()
        self.presenter = MovieDetailPresenter()
        
    
    }



}
