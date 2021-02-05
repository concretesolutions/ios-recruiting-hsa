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
    var movies: [Movie] = []
    
    //MARK: - App lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        self.presenter.fetchMovies()
        // Do any additional setup after loading the view.
    }

}


//MARK: - Display Logic

extension MoviesViewController: PresenterToViewMoviesProtocol {
    func fetchMoviesSuccessfull(_ movies: [Movie]) {
        self.movies = movies
    }
    
    func failure(_ error: Error) {
        let alert = UIAlertController(title: "ATENCION!", message: error.localizedDescription, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}
