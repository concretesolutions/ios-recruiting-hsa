//
//  FirstViewController.swift
//  ConcreteIOsRecruit
//
//  Created by Matías Contreras Selman on 11/17/18.
//  Copyright © 2018 Matias Contreras. All rights reserved.
//

import UIKit

class FirstViewController: UIViewController {

    @IBOutlet weak var moviesCollectionView: MoviesCollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.getMovies()
    }

    func getMovies(){
        MoviesAPIManager().getPopularMovies { (movies, error) in
            if let error = error{
                debugPrint("There are no movies to display: \(error)")
                return
            }
            if let movies = movies{
                self.moviesCollectionView.movies = movies
            }
        }
    }

}

