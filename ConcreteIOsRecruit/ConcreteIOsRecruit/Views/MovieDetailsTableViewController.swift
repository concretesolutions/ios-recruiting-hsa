//
//  MovieDetailsTableViewController.swift
//  
//
//  Created by Matías Contreras Selman on 11/19/18.
//

import UIKit

class MovieDetailsTableViewController: UITableViewController {

    var favoritesDataManager = FavoritesDataManger()
    var movie : Movie? = nil
    var rightNavigationItem : UIBarButtonItem? = nil
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var genreLbl: UILabel!
    @IBOutlet weak var originalTitleLbl: UILabel!
    @IBOutlet weak var overviewLbl: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //remove extra empty cells
        tableView.tableFooterView = UIView()
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 300
        render()
        addFavButton()
    }
    
    func render(){
        if let movie = movie{
            print(movie.fullImageUrl)
            imageView.kf.setImage(with: movie.fullImageUrl)
            titleLbl.text = movie.title
            //genreLbl.text = movie.genreIDS.map
            originalTitleLbl.text = movie.originalTitle
            overviewLbl.text = movie.overview
        }
    }
    
    func getMovieGenres(){
        
        for var (i, movie) in response?.results.enumerated() ?? [].enumerated(){
            var movieGenres = [Genre]()
            for genreId in movie.genreIDS{
                
                for genre in genres ?? []{
                    if genre.id == genreId{
                        movieGenres.append(genre)
                        //movie.genres.append(genre)
                    }
                }
            }
            debugPrint("the genres for the movie : \(movie.title)  should be \(movie.genreIDS.count) are: \(movieGenres.count): \(movieGenres)")
            response?.results[i].genres = movieGenres
            //for movie.
            //movie.genres = genres.filter({$0.id in movie.genreIDS})
        }
        
        for movie in response?.results ?? []{
            debugPrint(movie.genres)
        }
    }

    func addFavButton(){
        let image : UIImage = UIImage(named: "favorite_empty_icon")!
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: image, style: .plain, target: self, action: #selector(MovieDetailsTableViewController.addRemoveFromFav))
        changeButtonState()
    }
    
    func changeButtonState(){
        var image : UIImage? = nil
        if let movie = self.movie{
            if favoritesDataManager.isAlreadyInFavorites(movie: movie) {
                image = UIImage(named: "favorite_full_icon")
            }
            else{
                image = UIImage(named: "favorite_empty_icon")
            }
            self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: image, style: .plain, target: self, action: #selector(MovieDetailsTableViewController.addRemoveFromFav))
        }
    }
    
    @objc func addRemoveFromFav(){
        if let movie = self.movie{
            _ = favoritesDataManager.addRemoveMovie(movie: movie)
            self.changeButtonState()
            
        }
    }
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}
