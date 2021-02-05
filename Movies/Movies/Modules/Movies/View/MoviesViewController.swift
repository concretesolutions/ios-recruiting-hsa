//
//  MoviesViewController.swift
//  Movies
//
//  Created by Alfredo Luco on 05-02-21.
//

import UIKit

class MoviesViewController: ViewController {
    
    //MARK: - Memory debug
    
    deinit {
        print("Movies vc dealloc")
    }
    
    //MARK: - Variables
    
    var presenter: MoviesPresenter = MoviesPresenter()
    
    //MARK: - App lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

}


//MARK: - Display Logic

extension MoviesViewController: PresenterToViewMoviesProtocol {
    
}
