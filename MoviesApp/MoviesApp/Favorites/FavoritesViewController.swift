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

        self.showSpinner()
        // Do any additional setup after loading the view.
        presenter.setViewDelegate(delegate: self)
        presenter.getFavorites()
        
        favoriteMoviesTableView.dataSource = self
        favoriteMoviesTableView.delegate = self
        favoriteMoviesTableView.rowHeight = 200
        
        navigationController?.navigationBar.backgroundColor = UIColor(named:ColorsMovie.Yellow)
        tabBarController?.tabBar.backgroundColor = UIColor(named: ColorsMovie.Yellow)
    }
    
    func presentMoviesFavorites(movies: [MovieDB]) {
        self.favortiteMovies = movies
        
        DispatchQueue.main.async {
            self.favoriteMoviesTableView.reloadData()
            self.removeSpinner()
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
    
     func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
         
         if editingStyle == .delete {
             favortiteMovies.remove(at: indexPath.row)
             favoriteMoviesTableView.deleteRows(at: [indexPath], with: .fade)
             
             //Quitar de la Persistencia de datos
         }
         
    }
    
}

//MARK: - 
extension FavoritesViewController:UITableViewDelegate{
    func tableView(_ tableView: UITableView, titleForDeleteConfirmationButtonForRowAt indexPath: IndexPath) -> String? {
           return "Unfavorite"
   }
}


