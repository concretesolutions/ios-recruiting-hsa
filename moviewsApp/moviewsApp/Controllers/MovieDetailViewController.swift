//
//  MovieDetailViewController.swift
//  moviewsApp
//
//  Created by carlos jaramillo on 8/31/18.
//  Copyright © 2018 carlos jaramillo. All rights reserved.
//

import UIKit

class MovieDetailViewController: UIViewController {

    @IBOutlet weak var likeButton: UIButton!
    @IBOutlet weak var posterMovieImage: UIImageView!
    @IBOutlet weak var overviewLabel: UILabel!
    @IBOutlet weak var genresLabel: UILabel!
    @IBOutlet weak var yearLabel: UILabel!
    @IBOutlet weak var nameMovieLabel: UILabel!
    @IBOutlet weak var scroll: UIScrollView!
    @IBOutlet weak var topLayoutButton: NSLayoutConstraint!
    
    var movie : Movie?
    
    override func viewDidLoad() {
        super.viewDidLoad()
     
        scroll.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.tabBarController?.tabBar.isHidden = true
        self.tabBarController?.tabBar.isTranslucent = true
        self.loadDataView()
    }
    
    func loadDataView(){
        guard   let path = self.movie?.posterPath ,
                let overview = self.movie?.overview ,
                let genres = self.movie?.genreIds ,
                let year = self.movie?.releaseDate ,
                let name = self.movie?.title,
                let id = self.movie?.id else{
                
            return
        }
        
        self.posterMovieImage.loadPicture(of: "\(baseURLS.posters.rawValue)\(path)")
        
        self.overviewLabel.text = overview
        self.overviewLabel.numberOfLines = 0
        self.overviewLabel.lineBreakMode = .byWordWrapping
        self.overviewLabel.preferredMaxLayoutWidth = self.scroll.frame.width
        
        likeButton.setImage(#imageLiteral(resourceName: "favorite").withRenderingMode(.alwaysTemplate), for: .normal)
        if Movie.favorites.filter({$0.id == id}).count > 0{
            self.likeButton.tintColor = UIColor(named: "principalColor")
        }
        else{
            self.likeButton.tintColor = .gray
        }
        
        self.genresLabel.text = self.generateGenreText(genreIds: genres)
        
        self.yearLabel.text = year.split(separator: "-")[0].description
        
        self.nameMovieLabel.text = name
        
        self.title = name
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        
        self.scroll.layoutIfNeeded()
        self.scroll.contentSize.height = self.overviewLabel.frame.maxY + 10
    }
    
    func generateGenreText(genreIds : [Int]) -> String{
        if Genre.genres.isEmpty{
            return ""
        }
        var text = ""
        genreIds.forEach { (id) in
            let array = Genre.genres.filter({$0.id == id})
            if array.isEmpty == false{
                text = text + array[0].name! + (id == genreIds.last! ? "" : ",")
            }
        }
        return text
    }

    @IBAction func tapHeart(_ sender: UIButton) {
        guard let id = movie?.id else {
            return
        }
        if Movie.favorites.filter({$0.id == id}).count > 0{
            Movie.removeFavoriteMovie(withID: id)
            self.likeButton.tintColor = .gray
        }
        else{
            Movie.saveFavoriteMovie(movie: movie!)
            self.likeButton.tintColor = UIColor(named: "principalColor")
        }
    }
}

extension MovieDetailViewController : UIScrollViewDelegate{
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        self.topLayoutButton.constant = 512 + (scrollView.contentOffset.y * -1)
    }
}

