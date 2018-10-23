//
//  DetailMovieTableViewController.swift
//  TestProject
//
//  Created by Felipe S Vergara on 21-10-18.
//  Copyright © 2018 MyOwnCompany. All rights reserved.
//

import UIKit
import Kingfisher
import SVProgressHUD

class DetailMovieTableViewController: UITableViewController {
    
    //FavoriteButton
    @IBOutlet weak var favButtopn: UIButton!
    var presenter: DetailMoviePresenter?
    //Selected movie
    var movie: Movie?
    //Is favorite?
    var isFav = false
    
    //Outlets
    @IBOutlet weak var movieImage: UIImageView!
    @IBOutlet weak var movieDate: UILabel!
    @IBOutlet weak var movieTitle: UILabel!
    @IBOutlet weak var movieReview: UILabel!
    @IBOutlet weak var movieVotes: UILabel!
    @IBOutlet weak var movieOverview: UILabel!
    @IBOutlet weak var movieReleaseDate: UILabel!
    @IBOutlet weak var movieOriginalTitle: UILabel!
    @IBOutlet weak var movieGenres: UILabel!
    @IBOutlet weak var blurBackground: UIView!
    @IBOutlet weak var roundedDateBackground: UIView!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Init Presenter
        self.presenter = DetailMoviePresenter(delegate: self)
        
        //Render the view
        render()
    }

    func render(){
        //TableView Setup
        tableView.tableFooterView = UIView()
        tableView.rowHeight = UITableView.automaticDimension
        
        //Render rounded corners
        self.roundedDateBackground.roundedCorners(cRadius: 12)
        
        //Color
        self.roundedDateBackground.backgroundColor = UIColor(named: ColorName.DarkYellow.rawValue)
        
        if let movie = self.movie{
            //Load Favorites
            self.presenter?.loadFavorites(movieToCheck: movie)
            //Fetch genres
            self.presenter?.getMovieGenre(genres: movie.genreIDS)
            self.presenter?.formatDateFrom(dateToFormat: movie.releaseDate)
            self.movieImage.kf.setImage(with: movie.getUrlImage())
            self.movieTitle.text = movie.title
            self.movieReview.text = String(movie.voteAverage)
            self.movieVotes.text = "\(movie.voteCount) votos"
            self.movieOverview.text = movie.overview
            self.movieReleaseDate.text = movie.releaseDate
            self.movieOriginalTitle.text = movie.originalTitle
        }
    }
    
    
    @IBAction func favorite(_ sender: Any) {
        if let mov = movie{
            self.isFav ? self.presenter?.removeFavorite(movie: mov) : self.presenter?.addFavorite(movie: mov)
        }
    }
    
}

extension DetailMovieTableViewController :DetailMovieEventResponse{
    func showLoading(show: Bool) {
        show ? SVProgressHUD.show() : SVProgressHUD.dismiss()
    }
    
    func favoriteSaved() {
        if let movie = self.movie{
            isFav = true
            self.presenter?.loadFavorites(movieToCheck: movie)
        }
    }
    
    func favoriteRemoved() {
        if let movie = self.movie{
            isFav = false
            self.presenter?.loadFavorites(movieToCheck: movie)
        }
    }
    
    func favoritesLoaded(isFav: Bool) {
        favButtopn.favoriteType(show: isFav)
    }
    
    func genreLoaded(genreString: String) {
        self.movieGenres.text = genreString
    }
    
    func attachDate(newDate: String) {
        self.movieDate.text = newDate
    }
    
    
}
