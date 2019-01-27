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
import CoreData

class MovieDetailViewController: BaseViewController {

    @IBOutlet weak var movieImageView: UIImageView!
    @IBOutlet weak var movieTitleLabel: UILabel!
    @IBOutlet weak var movieIsFavoriteButton: UIButton!
    @IBOutlet weak var movieYearLabel: UILabel!
    @IBOutlet weak var movieCategoryLabel: UILabel!
    @IBOutlet weak var movieDescriptionLabel: UILabel!
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    
    var movieDetail : MovieDetail?
    var movieID : String?
    var movieBD : MovieEntity?
    var movieIsFavorite : Bool = false
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        callMovieFromServer(movieID: movieID!)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        verifyMovieIsFavorite(movieID: movieID!)
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
        
        
        realoadBtnFavorite()
        
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
    
    func realoadBtnFavorite() {
        let nameImage = movieIsFavorite ? "favorite_full_icon" : "favorite_gray_icon"
        movieIsFavoriteButton.setImage(UIImage(named: nameImage), for:.normal)
        movieIsFavoriteButton.addTarget(self, action: #selector(favoriteBtnPressed), for: .touchUpInside)
    }
    
    //MARK: - Action
    @objc func favoriteBtnPressed(sender : UIButton!) {
        if let movieSaved = movieBD {
            movieIsFavorite = false
            context.delete(movieSaved)
        } else {
            let movieEntity = MovieEntity(context: context)
            movieEntity.id = movieDetail!.movieID
            movieEntity.title = movieDetail!.movieTitle
            movieEntity.overview = movieDetail!.movieOverview
            movieEntity.image = movieDetail!.moviePosterPath
            movieEntity.year = movieDetail!.movieReleaseDate
            movieIsFavorite = true
        }
        saveMovie()
        realoadBtnFavorite()
        
    }
    
    func saveMovie() {
        do {
            try context.save()
        } catch {
            print("Error saving context \(error)")
        }
    }
    
    func verifyMovieIsFavorite(movieID : String) {
        let request : NSFetchRequest<MovieEntity> = MovieEntity.fetchRequest()
        let predicate = NSPredicate(format: "id = %@", movieID)
        request.predicate = predicate
        
        do {
            let movies = try (context.fetch(request))
            movieBD = movies.count > 0 ? movies[0] : nil
            movieIsFavorite = movies.count > 0
            
        } catch {
            print("Error fetching data \(error)")
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
