//
//  MovieListController.swift
//  Movies
//
//  Created by Daniel Nunez on 03-03-21.
//

import UIKit

protocol MovieListRefresh: class {
    func refresh()
}

protocol MovieListView: class {
    func showMovies(movies: [Movie]?)
    func loadMore(page: Int)
    func showDetailMovie(movie: Movie)
    func showError()
}

class MovieListController: UIViewController {

    @IBOutlet weak var search: UISearchBar!
    @IBOutlet weak var collection: UICollectionView!
    @IBOutlet weak var lblMessage: UILabel!

    var coordinator: MovieCoordinator?
    var presenter: MovieListPresenter!
    var dataSource: CollectionDelegateData!

    var searching: Bool = false
    var items: [Movie] = []
    var filterItems: [Movie] = []
    
    lazy var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(
            self,
            action:
            #selector(self.handleRefresh(_:)),
            for: UIControl.Event.valueChanged
        )
        return refreshControl
    }()

    // MARK: Lyfecylce
    override func viewDidLoad() {
        super.viewDidLoad()

        setCollection()
        presenter?.getMovies(with: dataSource.currentPage)
    }


    override func viewWillAppear(_ animated: Bool) {
        guard let presenter = presenter else { return }
        items = presenter.validFavorites(movies: items)
        filterItems = presenter.validFavorites(movies: items)

        collection.reloadData()

    }

    // MARK: Functions

    func checkData() {
        collection.isHidden = searching ? filterItems.isEmpty : items.isEmpty
        lblMessage.isHidden = searching ? !filterItems.isEmpty : !items.isEmpty
        lblMessage.text = searching ? NSLocalizedString("NoResult", comment: "") : NSLocalizedString("ErrorService", comment: "")
    }

    func setCollection() {
        dataSource = CollectionDelegateData(withDelegate: self, items)

        collection.delegate = dataSource
        collection.dataSource = dataSource
        collection.refreshControl = refreshControl
        collection.register(MovieCollectionViewCell.nib,
                            forCellWithReuseIdentifier: MovieCollectionViewCell.identifier)

        let collectionWidth = collection?.frame.width
        let cellWidth = (collectionWidth! - 40) / 2
        let layout = collection.collectionViewLayout as! UICollectionViewFlowLayout
        layout.itemSize = CGSize(width: cellWidth, height: 300)

    }

    func searchBy(with txt: String) -> [Movie]? {
        let textoABuscar = txt.folding(options: .diacriticInsensitive, locale: .current)
            .lowercased()
        let filtrado = items
            .filter {
                ($0.title?.folding(options: .diacriticInsensitive, locale: .current).lowercased()
                    .localizedCaseInsensitiveContains(textoABuscar))!
            }

        return filtrado
    }

    
}

extension MovieListController: MovieListView {
    func showError() {
        lblMessage.text = NSLocalizedString("ErrorService", comment: "")
    }

    func showMovies(movies: [Movie]?) {
        if dataSource.currentPage == 1 { self.items = movies! }
        else { self.items += movies! }

        dataSource.movies = items
        self.collection.reloadData()
    }

    func loadMore(page: Int) {
        presenter.getMovies(with: page)
    }

    func showDetailMovie(movie: Movie) {
        coordinator?.showMovieDetail(with: movie, delegate: self)
    }
}

extension MovieListController: MovieListRefresh {
    func refresh() {
        collection.reloadData()
    }
}

// MARK: - extension - handleRefresh
extension MovieListController {
    @objc func handleRefresh(_: UIRefreshControl) {
        collection.reloadData()
    }
}

// MARK: UISearchBarDelegate
extension MovieListController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        let str = searchText.trimmingCharacters(in: .whitespacesAndNewlines)

        if !str.isEmpty {
            let temp = searchBy(with: str)
            searching = true
            filterItems = temp!
            collection.reloadData()

        } else {
            searching = false
            collection.reloadData()
            searchBar.resignFirstResponder()
        }


    }

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        if let str = searchBar.text?.trimmingCharacters(in: .whitespacesAndNewlines) {
            if str.count > 0 {
                if let temp = searchBy(with: str) {
                    searching = true
                    filterItems = temp
                } else {
                    searching = false

                }
                collection.reloadData()
            }
        }
        searchBar.resignFirstResponder()
    }


    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searching = false
        searchBar.text = ""

        collection.reloadData()
        searchBar.resignFirstResponder()
    }

    func searchBarShouldEndEditing(_ searchBar: UISearchBar) -> Bool {
        searchBar.resignFirstResponder()
        return true
    }

}
