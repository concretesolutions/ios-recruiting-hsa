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
    @IBOutlet weak var lblMessage: UILabel!

    weak var coordinator: MovieCoordinator?

    lazy var items: [Movie] = []
    lazy var filteredItems: [Movie] = []

    var presenter: FavoritePresenter?
    var searching: Bool = false
    var currentMovie: Movie!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupTable()

    }

    override func viewWillAppear(_ animated: Bool) {
        presenter?.load()
    }

    func setupTable() {
        table.delegate = self
        table.dataSource = self
        table.register(FavouriteTableViewCell.nib, forCellReuseIdentifier: FavouriteTableViewCell.identifier)

    }

    func load(_ movies: [Movie]) {
        items = movies
        table.reloadData()

    }


    func checkData() {
        table.isHidden = searching ? filteredItems.isEmpty : items.isEmpty
        lblMessage.isHidden = searching ? !filteredItems.isEmpty : !items.isEmpty
        lblMessage.text = searching ? "No se han encontrado resultados" : "No existen favoritos agregados :("
    }

}

// MARK: - extension - UITableViewDataSource

extension FavoritesController: UITableViewDataSource {
    func numberOfSections(in _: UITableView) -> Int {
        checkData()
        return 1
    }

    func tableView(_: UITableView, numberOfRowsInSection _: Int) -> Int {
        return searching ? filteredItems.count : items.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        guard let cell = tableView.dequeueReusableCell(withIdentifier: FavouriteTableViewCell.identifier) as? FavouriteTableViewCell
        else { return UITableViewCell() }

        let movie = searching ? filteredItems[indexPath.row] : items[indexPath.row]
        currentMovie = movie
        cell.fill(with: movie)

        return cell
    }
}

// MARK: - extension - UITableViewDelegate

extension FavoritesController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle,
                   forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let movie = items[indexPath.row]
            presenter?.deleteFavorite(movie: movie)
            if searching {
                filteredItems.remove(at: indexPath.row)
            } else {
                items.remove(at: indexPath.row)
            }

            tableView.deleteRows(at: [indexPath], with: .fade)

        }
    }
}

extension FavoritesController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        let str = searchText.trimmingCharacters(in: .whitespacesAndNewlines)

        if !str.isEmpty {
            let temp = presenter?.searchBy(with: str)
            searching = true
            filteredItems = temp!
            table.reloadData()

        } else {

        }


    }

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        if let str = searchBar.text?.trimmingCharacters(in: .whitespacesAndNewlines) {
            if str.count > 0 {
                if let temp = presenter?.searchBy(with: str) {
                    searching = true
                    filteredItems = temp
                } else {
                    searching = false
                }
                table.reloadData()

            }
        }
        searchBar.resignFirstResponder()
    }


}
