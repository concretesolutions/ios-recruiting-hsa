//
//  FavoritesViewController.swift
//  MoviesApp
//
//  Created by gustavo.salazar on 17/06/22.
//

import UIKit

//MARK: - 
class FavoritesViewController: UIViewController ,FavoritesPresenterDelegate{
  
    @IBOutlet weak var favoriteMoviesTableView: UITableView!
    var presenter: FavoritesPresenter = FavoritesPresenter()
    var favortiteMovies:[MovieDB] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        presenter.setViewDelegate(delegate: self)
        presenter.getFavorites()
        
        favoriteMoviesTableView.dataSource = self
        favoriteMoviesTableView.rowHeight = 200

    }
    
    func presentMoviesFavorites(movies: [MovieDB]) {
        self.favortiteMovies = movies
        
        DispatchQueue.main.async {
            self.favoriteMoviesTableView.reloadData()
        }
    }
    
}
//MARK: -
extension FavoritesViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return favortiteMovies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Cells.movieFavoriteCell, for: indexPath) as! FavoriteViewCell
        let movie = favortiteMovies[indexPath.row]
        cell.configureCell(movie: movie)
        
        return cell
    }
    
    
}
