//
//  FavoriteListViewController.swift
//  GetMovieApp
//
//  Created by Training on 03-07-22.
//

import UIKit

class FavoriteListViewController: ViewController, UITableViewDelegate, UITableViewDataSource {
    
    //MARK: Oulets
    @IBOutlet weak var FavoriteTableView: UITableView!
    
    //MARK: Propertis
    var movieFavorites: [Favorites] = []
    
//    var moviesFavorites: [Favorites] = FavoritesManager.shared.moviesFavorites
//    let urlImage = "https://image.tmdb.org/t/p/w200"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        loadFavorite()
        FavoriteTableView.dataSource = self
        FavoriteTableView.delegate = self
        FavoriteTableView.reloadData()
        
        FavoritesManager.shared.printConsole()
        
    }
    //MARK: Action
    @IBAction func onTapLoadMovie(_ sender: Any) {       FavoriteTableView.reloadData()
    }
    
    //MARK: Functions TableView
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print(FavoritesManager.shared.moviesFavorites.count)
        return FavoritesManager.shared.moviesFavorites.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //plantilla de celda y prototipo con identificador para posicion index
        let cell: FavoriteTableViewCell = FavoriteTableView.dequeueReusableCell(withIdentifier: "FavoriteTableViewCell", for: indexPath) as! FavoriteTableViewCell
        //cambio de image url en imageview
        print(FavoritesManager.shared.moviesFavorites.count)
        
        let moviesFavorites: [Favorites] = FavoritesManager.shared.moviesFavorites
        let objMov = moviesFavorites[indexPath.row]
        let poster_path = objMov.posterPath
        //Llenar plantilla
        
        cell.movieImageSelect.loadFrom(URLAddress: "https://image.tmdb.org/t/p/w300\(poster_path!)")
        
        cell.nameMovieLabel.text = objMov.title
        cell.yearMovieLabel.text = objMov.releaseDate
        cell.descriptionMovieLabel.text = objMov.overview
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        movieFavorites = FavoritesManager.shared.moviesFavorites
        let movie = self.movieFavorites[indexPath.row].id
        performSegue(withIdentifier: "segueFavorite", sender: movie)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "segueFavorite"{
            if let controller = segue.destination as? DetailPageViewController {
                controller.idMovie = sender as! Int
            }
        }
    }

}
