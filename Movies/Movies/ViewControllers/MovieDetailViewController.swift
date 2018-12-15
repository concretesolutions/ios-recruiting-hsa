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
    @IBOutlet weak var favoriteButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let movie = self.movie{
            title = movie.title
            movieTitleLabel.text = movie.title
            let calendar = Calendar(identifier: .gregorian)
            movieReleaseYearLabel.text = "\(calendar.component(.year, from: movie.release_date ?? Date()))"
            movieOverviewLabel.text = movie.overview
            movieGenresLabel.text = movie.genresString
            if let url = URL(string: "https://image.tmdb.org/t/p/w500\(movie.backdrop_path)" ){
                movieBackdropImageView.af_setImage(withURL: url)
            }
            favoriteButton.setImage((movie.isFavorite ?? false ) ? UIImage(named: "btnFavoriteFull"):UIImage(named: "btnFavoriteEmpty"), for: .normal)
        }
        // Do any additional setup after loading the view.
    }
    
    var movie: Movie? = nil
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    
    @IBAction func setFavoriteAction(_ sender: Any) {
        if let button = sender as? UIButton {
            movie?.setFavorite()
            if movie?.isFavorite ?? false {
                button.setImage(UIImage(named: "btnFavoriteEmpty"), for: .normal)
            } else {
                button.setImage(UIImage(named: "btnFavoriteFull"), for: .normal)
            }
        }
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
