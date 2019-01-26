//
//  MovieDetailViewController.swift
//  MovieApp
//
//  Created by luis.a.rosas.arce on 22/01/19.
//  Copyright © 2019 luis.a.rosas.arce. All rights reserved.
//

import UIKit
import SwiftyJSON
class MovieDetailViewController: UIViewController {

    @IBOutlet weak var movieImageView: UIImageView!
    @IBOutlet weak var movieTitleLabel: UILabel!
    @IBOutlet weak var movieIsFavoriteButton: UIButton!
    @IBOutlet weak var movieYearLabel: UILabel!
    @IBOutlet weak var movieCategoryLabel: UILabel!
    @IBOutlet weak var movieDescriptionLabel: UILabel!
    
    var movie : Movie?
    var movieID : String?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        callMovieFromServer(movieID: movieID!)
        //setupViewWithMovie(movie: movie!)
    }
    
    
    func setupViewWithMovie(movie : Movie){
        movieTitleLabel.text = movie.movieTitle
        movieYearLabel.text = movie.movieReleaseDate
        movieDescriptionLabel.text = movie.movieOverview
    }
    
    func callMovieFromServer(movieID : String) {
        APIManager.sharedInstance.getMovie(idMovie: movieID, onSuccess: { json in
            DispatchQueue.main.async {
                //print(String(describing: json));
                
                
            }
        }, onFailure: { error in
            let alert = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Dismiss", style: .default, handler: nil))
            self.show(alert, sender: nil)
        })
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
