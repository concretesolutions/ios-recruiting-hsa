//
//  StarredsViewController.swift
//  Movies
//
//  Created by Alfredo Luco on 07-02-21.
//

import UIKit

class StarredsViewController: ViewController {
    
    //MARK: - Memory debug
    
    deinit {
        print("starreds vc dealloc")
    }
    
    //MARK: - Variables
    
    var presenter: StarredsPresenter = StarredsPresenter()
    
    //MARK: - App lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

}


//MARK: - Display Logic

extension StarredsViewController: PresenterToViewStarredsProtocol {
    func fetchStarredsMoviesSuccessfull(_ movies: [Movie]) {
        
    }
    
    func unstarMovieSuccessfull() {
        self.presenter.fetchStarredsMovies()
    }
    
    func failure(_ error: Error) {
        let alert = UIAlertController(title: "ATENCION", message: error.localizedDescription, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}
