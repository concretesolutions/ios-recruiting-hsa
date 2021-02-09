//
//  MovieDetailViewController.swift
//  concreteIOSRecruitChallenge
//
//  Created by Kristian Sthefan Cortes Prieto on 04-02-21.
//

import UIKit

class MovieDetailViewController: UIViewController {
    
    //MARK: Outlets

    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var yearLabel: UILabel!
    @IBOutlet var genresLabel: UILabel!
    @IBOutlet var photoImageView: UIImageView!
    @IBOutlet var favoriteImageView: UIImageView!
    @IBOutlet var descriptionTextView: UITextView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    //MARK: Global Variables
    
    private var viewModel: MovieDetailViewModel?
    var data: MovieEntry?
    
    //MARK: View Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.viewModel = MovieDetailViewModel()
        self.loadViews()
    }
    private func loadViews(){
        self.titleLabel.text = self.data?.title ?? "No title"
        self.yearLabel.text = self.data?.getYear()
        self.genresLabel.text = "Loading..."
        
        if let movieId = self.data?.id {
            if(self.viewModel?.isFavorite(id: movieId) == true) {
                self.favoriteImageView?.image = #imageLiteral(resourceName: "favorite_full_icon")
            } else {
                self.favoriteImageView?.image = #imageLiteral(resourceName: "favorite_gray_icon")
            }
        }
        
        self.descriptionTextView.text = self.data?.overview ?? "No overview"
        if let poster = self.data?.poster_path { self.photoImageView.loadFromUrl(url: "\(Constants.imageEndpoint)/t/p/w500/\(poster)", activityIndicator: self.activityIndicator, errorImage: #imageLiteral(resourceName: "empty_photo")) }
    }
    
    //MARK: Button Actions
    
    @IBAction func favoriteButtonPress(){
        if let movieId = self.data?.id {
            if (self.viewModel?.isFavorite(id: movieId) == true){
                _ = self.viewModel?.removeFavorite(id: movieId)
                self.favoriteImageView?.image = #imageLiteral(resourceName: "favorite_gray_icon")
            }else{
                if let movie = self.data {
                    self.viewModel?.addFavorite(movie: movie)
                    self.favoriteImageView?.image = #imageLiteral(resourceName: "favorite_full_icon")
                }
            }
        }
    }
}
