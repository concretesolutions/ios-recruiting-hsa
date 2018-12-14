//
//  MovieDetailViewController.swift
//  Movies
//
//  Created by Consultor on 12/13/18.
//  Copyright © 2018 Mavzapps. All rights reserved.
//

import UIKit

class MovieDetailViewController: UIViewController {

    @IBOutlet weak var movieBackdropImageView: UIImageView!
    @IBOutlet weak var movieTitleLabel: UILabel!
    @IBOutlet weak var movieReleaseYearLabel: UILabel!
    @IBOutlet weak var movieGenresLabel: UILabel!
    @IBOutlet weak var movieOverviewLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let movie = self.movie{
            title = movie.title
            movieTitleLabel.text = movie.title
            movieReleaseYearLabel.text = movie.release_date
            movieOverviewLabel.text = movie.overview
            
            if let url = URL(string: "https://image.tmdb.org/t/p/w500\(movie.backdrop_path)" ){
                
                movieBackdropImageView.af_setImage(withURL: url)
                
            }
        }
        // Do any additional setup after loading the view.
    }
    
    var movie: Movie? = nil
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
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
