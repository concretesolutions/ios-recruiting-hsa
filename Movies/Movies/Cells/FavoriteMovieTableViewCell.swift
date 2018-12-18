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
    
    var viewModel = FavoriteViewModel(){
        didSet{
            movieTitleLabel.text = viewModel.title
            movieOverviewLabel.text = viewModel.overview
            let calendar = Calendar(identifier: .gregorian)
            movieReleaseYearLabel.text = "\(calendar.component(.year, from: viewModel.releaseDate))"
            if let url = URL(string: NetworkAPIManager().baseUrlImages+"\(viewModel.imagePath)" ){
                moviePosterImageView.af_setImage(withURL: url)
            }
        }
    }

}
extension FavoriteMovieTableViewCell {
    struct FavoriteViewModel{
        var title = ""
        var overview = ""
        var releaseDate = Date()
        var imagePath = ""
    }
}
extension FavoriteMovieTableViewCell.FavoriteViewModel{
    init(_ movie: Movie){
        title = movie.title
        overview = movie.overview
        releaseDate = movie.release_date ?? Date()
        imagePath = movie.poster_path
    }
}
