//
//  MovieDetailViewController.swift
//  movieFinder
//
//  Created by Francisco Zuniga De Spirito on 29-09-22.
//

import Foundation
import UIKit

class MovieDetailViewController: UIViewController {
    
    @IBOutlet weak var moviePhotoImageView: UIImageView!
    
    @IBOutlet weak var favoriteImageView: UIImageView!
    
    @IBOutlet weak var movieNameLabel: UILabel!
    
    @IBOutlet weak var movieReleaseYearLabel: UILabel!
    
    @IBOutlet weak var movieGenresLabel: UILabel!
    
    @IBOutlet weak var movieDescriptionLabel: UILabel!
    
    // TO-DO: maybe use id here
    var movieId: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
                
        MovieAPI().getMovieDetail(movieId) { movie in
            if let url = URL(string: movie.backdropImageURL ?? "") {
                let task = URLSession.shared.dataTask(with: url) { data, response, error in
                    guard let data = data, error == nil else { return }
                    
                    DispatchQueue.main.async {
                        self.moviePhotoImageView.image = UIImage(data: data)
                    }
                }
                
                task.resume()
            }
            
            self.movieNameLabel.text = movie.name
            self.movieReleaseYearLabel.text = movie.releaseDate
            self.movieDescriptionLabel.text = movie.descriptionText
            self.movieGenresLabel.text = movie.genres
        }
    }
}
