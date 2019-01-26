//
//  MovieDetailViewController.swift
//  MovieApp
//
//  Created by luis.a.rosas.arce on 22/01/19.
//  Copyright © 2019 luis.a.rosas.arce. All rights reserved.
//

import UIKit
import SwiftyJSON
import SDWebImage


class MovieDetailViewController: BaseViewController {

    @IBOutlet weak var movieImageView: UIImageView!
    @IBOutlet weak var movieTitleLabel: UILabel!
    @IBOutlet weak var movieIsFavoriteButton: UIButton!
    @IBOutlet weak var movieYearLabel: UILabel!
    @IBOutlet weak var movieCategoryLabel: UILabel!
    @IBOutlet weak var movieDescriptionLabel: UILabel!
    
    var movieDetail : MovieDetail?
    var movieID : String?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        callMovieFromServer(movieID: movieID!)
    }
    
    
    func setupViewWithMovie(movieDetail : MovieDetail){
        movieTitleLabel.text = movieDetail.movieTitle
        movieTitleLabel.numberOfLines = 0
        Tools.sharedInstance.styleLabelForDetail(label: movieTitleLabel)
        //movieTitleLabel.font = UIFont(name: "helvetica", size: 15)
        
        movieYearLabel.text = movieDetail.getYearFromMovie()
        Tools.sharedInstance.styleLabelForDetail(label: movieYearLabel)
        
        movieDescriptionLabel.text = movieDetail.movieOverview
        Tools.sharedInstance.styleLabelForDetail(label: movieDescriptionLabel)
        movieDescriptionLabel.numberOfLines = 0
        
        movieCategoryLabel.text = movieDetail.getGenresMovieString()
        movieCategoryLabel.numberOfLines = 0
        Tools.sharedInstance.styleLabelForDetail(label: movieCategoryLabel)
        
        movieImageView.sd_setImage(with: URL(string: movieDetail.movieBackdropPath), placeholderImage: UIImage(named: ""))
    }
    
    func callMovieFromServer(movieID : String) {
        self.showLoader()
        APIManager.sharedInstance.getMovie(idMovie: movieID, onSuccess: { json in
            DispatchQueue.main.async {
                self.movieDetail = MovieDetail(json: json)
                self.setupViewWithMovie(movieDetail: self.movieDetail!)
                self.hideLoader()
                
            }
        }, onFailure: { error in
            let alert = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Dismiss", style: .default, handler: nil))
            self.show(alert, sender: nil)
            self.hideLoader()
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
