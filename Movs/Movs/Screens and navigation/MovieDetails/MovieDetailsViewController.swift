//
//  MovieDetailsViewController.swift
//  Movs
//
//  Created by Miguel Duran on 1/6/19.
//  Copyright © 2019 Miguel Duran. All rights reserved.
//

import UIKit

class MovieDetailsViewController: UIViewController, Networked, Stateful {
    var stateController: StateController?
    var networkController: NetworkController?
    var dataSource: MovieDetailsTableViewDataSource?
    var movie: Movie?
    @IBOutlet weak var tableView: UITableView!
}

extension MovieDetailsViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let movie = movie else {
            return
        }
        self.dataSource = MovieDetailsTableViewDataSource(movie: movie)
        tableView.dataSource = dataSource
        tableView.reloadData()
    }
}

extension MovieDetailsViewController: TitleFavoriteCellDelegate {
    func titleFavoriteCell(_ cell: TitleFavoriteCell) {
        guard let dataSource = dataSource, let indexPath = tableView.indexPath(for: cell) else {
            return
        }
        dataSource.toggleFavorite(at: indexPath.row)
        movie?.isFavorite = dataSource.isFavorite
        tableView.reloadRows(at: [indexPath], with: .none)
        guard let movie = movie else { return }
        if dataSource.isFavorite {
            stateController?.addMovie(movie)
        } else {
            stateController?.removeMovie(movie)
        }
    }
}

extension MovieDetailsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        (cell as? TitleFavoriteCell)?.delegate = self
        
        if let posterCell = cell as? PosterCell, let movie = movie {
            networkController?.fecthImage(url: TMDBEndpoint.imageRootURL, imagePath: movie.posterPath, withCompletion: { result in
                (try? result.get()).map { image in
                    DispatchQueue.main.async {
                        posterCell.poster = image
                    }
                }
            })
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}

extension MovieDetailsViewController {
    enum Row {
        case poster(UIImage)
        case titleFavorite(String, Bool)
        case year(String)
        case genres(String)
        case overview(String)
        
        var cellType: UITableViewCell.Type {
            switch self {
            case .poster: return PosterCell.self
            case .titleFavorite: return TitleFavoriteCell.self
            case .year, .genres: return DetailCell.self
            case .overview: return OverviewCell.self
            }
        }
    }
}
