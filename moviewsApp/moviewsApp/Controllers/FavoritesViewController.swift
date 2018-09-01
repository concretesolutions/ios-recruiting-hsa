//
//  FavoritesViewController.swift
//  moviewsApp
//
//  Created by carlos jaramillo on 8/29/18.
//  Copyright © 2018 carlos jaramillo. All rights reserved.
//

import UIKit

class FavoritesViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.tableView.delegate = self
        self.tableView.dataSource = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.title = "Favorites"
        self.tableView.reloadData()
    }

}

extension FavoritesViewController : UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let delete = UITableViewRowAction(style: .destructive, title: "UNFAVORITE") { (action, indexPath) in
            Movie.favorites.remove(at: indexPath.row)
            tableView.performBatchUpdates({
                tableView.deleteRows(at: [indexPath], with: .fade)
            }, completion: nil)
        }
        
        return [delete]
    }
}

extension FavoritesViewController : UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Movie.favorites.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "favorite-movie-cell", for: indexPath) as! FavofiteMovieTableViewCell
        
        cell.titleLabel.text = Movie.favorites[indexPath.row].title
        cell.overviewLabel.text = Movie.favorites[indexPath.row].overview
        cell.yearLabel.text = Movie.favorites[indexPath.row].releaseDate?.split(separator: "-")[0].description
        guard let posterPath = Movie.favorites[indexPath.row].posterPath else {
            return cell
        }
        cell.posterImage.loadPicture(of: "\(baseURLS.posters.rawValue)\(posterPath)")
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 124
    }
}

extension FavoritesViewController : UIScrollViewDelegate{
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        self.view.endEditing(true)
    }
}
