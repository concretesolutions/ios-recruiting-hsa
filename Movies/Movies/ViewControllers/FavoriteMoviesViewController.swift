//
//  FavoriteMoviesViewController.swift
//  Movies
//
//  Created by Consultor on 12/15/18.
//  Copyright © 2018 Mavzapps. All rights reserved.
//

import UIKit

class FavoriteMoviesViewController: UIViewController {

    @IBOutlet weak var favoriteMoviesTableView: UITableView!
    
    var favoriteMoviesArray: [Movie] = []
    var genres: [Genre] = []
    
    let cellIdentifier = "MovieTableViewCell"
    
    let detailSegueIdentifier = "ShowFavoriteMovieDetail"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //favoriteMoviesArray = DefaultsManager().favoriteMovies
        // Do any additional setup after loading the view.
        favoriteMoviesTableView.tableFooterView = UIView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        favoriteMoviesArray = DefaultsManager().favoriteMovies
        for (index, _) in self.favoriteMoviesArray.enumerated(){
            self.favoriteMoviesArray[index].setGenreString(self.genres)
            self.favoriteMoviesArray[index].isFavorite = DefaultsManager.shared.isMovieFavorite(self.favoriteMoviesArray[index])
        }
        favoriteMoviesTableView.reloadData()
    }
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        if segue.identifier == detailSegueIdentifier{
            if let destination = segue.destination as? MovieDetailViewController {
                destination.movie = sender as? Movie
            }
        }
    }
    

}
extension FavoriteMoviesViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return favoriteMoviesArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? FavoriteMovieTableViewCell {
            cell.movie = favoriteMoviesArray[indexPath.item]
            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: detailSegueIdentifier, sender: favoriteMoviesArray[indexPath.row])
    }
    
    
}

