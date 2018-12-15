//
//  FavoriteMovieTableViewCell.swift
//  Movies
//
//  Created by Consultor on 12/15/18.
//  Copyright © 2018 Mavzapps. All rights reserved.
//

import UIKit

class FavoriteMovieTableViewCell: UITableViewCell {

    @IBOutlet weak var moviePosterImageView: UIImageView!
    @IBOutlet weak var movieTitleLabel: UILabel!
    @IBOutlet weak var movieReleaseYearLabel: UILabel!
    @IBOutlet weak var movieOverviewLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    var movie: Movie? {
        didSet{
            if let movie = self.movie{
                movieTitleLabel.text = movie.title
                movieOverviewLabel.text = movie.overview
                let calendar = Calendar(identifier: .gregorian)
                movieReleaseYearLabel.text = "\(calendar.component(.year, from: movie.release_date ?? Date()))"
                if let url = URL(string: "https://image.tmdb.org/t/p/w500\(movie.poster_path)" ){
                    moviePosterImageView.af_setImage(withURL: url)
                }
            }
        }
    }

}
