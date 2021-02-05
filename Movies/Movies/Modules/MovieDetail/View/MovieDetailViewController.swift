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

        self.presenter.fetchCategories()
        self.presenter.fetchMovie()
        // Do any additional setup after loading the view.
    }

}

//MARK: - Display Logic

extension MovieDetailViewController: PresenterToViewMovieDetailProtocol {
    func fetchMovieSuccessfull(_ movie: Movie) {
        
    }
    
    func fetchCategoriesSuccessfull(_ categories: [Category]) {
        
    }
    
    func failure(_ error: Error) {
        let alert = UIAlertController(title: "ATENCION", message: error.localizedDescription, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}
