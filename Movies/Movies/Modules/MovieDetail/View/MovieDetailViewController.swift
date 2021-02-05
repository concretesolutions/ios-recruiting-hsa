//
//  MovieDetailViewController.swift
//  Movies
//
//  Created by Alfredo Luco on 05-02-21.
//

import UIKit

class MovieDetailViewController: ViewController {
    
    //MARK: - Memory debug
    
    deinit {
        print("Movie detail vc dealloc")
    }
    
    //MARK: - Variables
    
    var presenter: MovieDetailPresenter = MovieDetailPresenter()

    //MARK: - App lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

}

//MARK: - Display Logic

extension MovieDetailViewController: PresenterToViewMovieDetailProtocol {
    
}
