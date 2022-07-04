//
//  FavViewController.swift
//  iOS-movieApp
//
//  Created by alvaro.concha on 30-06-22.
//

import UIKit

class FavViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var FavMoviesTableView : UITableView!
    
    let userDefaults = UserDefaults.standard
    var idsPopularMovies : [Int]?
    var popularMovies : [MovieResult] = []
    var movieSelectedForSend : MovieResult?
    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        
        if FavManagerSingleton.shared.checkFavoriteMovies(){
            setupUI()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        FavMoviesTableView.reloadData()
        
    }
    func setupUI(){
        let apiManager = APIManager()

        apiManager.getPopularMovies { (MovieResult) in
            
            guard let movie = MovieResult else{ return }
            self.popularMovies = movie
            
        }
        
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return FavManagerSingleton.shared.favoritesMovies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellTableFavs", for: indexPath) as! ItemFavTableViewCell
        
        cell.pictureMovieImageView.downloaded(from: Endpoints.images +  FavManagerSingleton.shared.favoritesMovies[indexPath.row].poster_path )

        cell.pictureMovieImageView.contentMode = .scaleAspectFill
        cell.titleMovieLabel.text = FavManagerSingleton.shared.favoritesMovies[indexPath.row].title
        cell.desciptionTextView.text = FavManagerSingleton.shared.favoritesMovies[indexPath.row].overview
        
        let myDate = Date()
        cell.anioMovieLabel.text = myDate.getYearFromString(dateString: FavManagerSingleton.shared.favoritesMovies[indexPath.row].release_date)

        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let movieSelected = FavManagerSingleton.shared.favoritesMovies[indexPath.row]
        
        movieSelectedForSend = movieSelected
        self.performSegue(withIdentifier: "favoriteToSingleMovie", sender: nil)
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete{
            tableView.beginUpdates()
            var indexForDelete : Int = 0
            
            
            let movieToDeleted = FavManagerSingleton.shared.favoritesMovies[indexPath.row]
            
            
            
            for (i, id) in FavManagerSingleton.shared.idsFavoriteMovies.enumerated(){
                if id == movieToDeleted.id{
                   indexForDelete = i
                }
            }
            
            FavManagerSingleton.shared.deleteMovieFromFavorites(movieIndex: indexForDelete, movieDeleted: movieToDeleted)
            tableView.deleteRows(at: [indexPath], with: .fade)
            tableView.endUpdates()
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let singleMovieViewController = segue.destination as? SingleMovieViewController {
            guard let movieForSend = movieSelectedForSend else { return }
            singleMovieViewController.Movie = movieForSend
        }
    }
}
