//
//  FavoritesViewController.swift
//  TMDB Reloaded
//
//  Created by Miguel Duran on 1/5/19.
//  Copyright © 2019 Miguel Duran. All rights reserved.
//

import UIKit

class FavoritesViewController: UIViewController, Stateful, Networked  {
    var networkController: NetworkController?
    var stateController: StateController?
    var dataSource: FavoritesTableViewDataSource?
    
    @IBOutlet weak var tableView: UITableView!
    
    private var deletedMovie: Movie!
}

extension FavoritesViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let movies = stateController?.moviesDictionary.map({ (key, value) -> Movie in
            return value
        }) else { return }
        dataSource = FavoritesTableViewDataSource(movies: movies)
        tableView.dataSource = dataSource
        tableView.reloadData()
    }
}

extension FavoritesViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        guard let dataSource = dataSource, let movieCell = cell as? FavoriteMovieCell else { return }
        let movie = dataSource.movie(at: indexPath.row)
        
        guard let posterPath = movie.posterPath else { return }
        networkController?.fecthImage(url: TMDBEndpoint.imageRootURL, imagePath: posterPath, withCompletion: { result in
            (try? result.get()).map { image in
                DispatchQueue.main.async {
                    movieCell.posterImage = image
                }
            }
        })
    }
    
    func tableView(_ tableView: UITableView, didEndEditingRowAt indexPath: IndexPath?) {
        stateController?.removeMovie(deletedMovie)
    }
    
    func tableView(_ tableView: UITableView, willBeginEditingRowAt indexPath: IndexPath) {
        if let dataSource = dataSource {
            deletedMovie = dataSource.movie(at: indexPath.row)
        }
    }
    
}
