//
//  FavoritesController.swift
//  Movies
//
//  Created by Daniel Nunez on 03-03-21.
//

import UIKit

protocol FavoriteProtocol: class {

    func load(_ movies: [Movie])
}

class FavoritesController: UIViewController, FavoriteProtocol {

    @IBOutlet weak var search: UISearchBar!
    @IBOutlet weak var table: UITableView!
    
    weak var coordinator: MainCoordinator?
    lazy var items: [Movie] = []
    var presenter: FavoritePresenter?

    
    override func viewDidLoad() {
        super.viewDidLoad()

        presenter?.load()
    }

    func setupTable(){
        table.register(FavoriteTableViewCell.nib, forCellReuseIdentifier: FavoriteTableViewCell.identifier)

    }

    func load(_ movies: [Movie]) {
        items = movies
    }


}

// MARK: - extension - UITableViewDataSource

extension FavoritesController: UITableViewDataSource {
    func numberOfSections(in _: UITableView) -> Int {
        return 1
    }

    func tableView(_: UITableView, numberOfRowsInSection _: Int) -> Int {
        return items.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        return UITableViewCell()
    }
}

// MARK: - extension - UITableViewDelegate

extension FavoritesController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle,
                   forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let movie = items[indexPath.row]
            presenter?.deleteFavorite(movie: movie)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
}
