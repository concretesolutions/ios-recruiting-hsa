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

    var coordinator: MovieCoordinator?
    var presenter: MovieListPresenter!
    var dataSource: CollectionDelegateData!

    let items: Observable<[Movie]> = Observable([])

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

    override func viewDidLoad() {
        super.viewDidLoad()

        setCollection()
        items.observe(on: self) { [weak self] _ in self?.refresh() }
        presenter?.getMovies(with: dataSource.currentPage)
    }

    func setCollection() {
        dataSource = CollectionDelegateData(withDelegate: self, items.value)
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


}

extension MovieListController: MovieListView {
    func showError() {
        collection.isHidden = true

    }

    func showMovies(movies: [Movie]?) {
        if dataSource.currentPage == 1 { self.items.value = movies! }
        else { self.items.value += movies! }

        dataSource.movies = items.value
        self.collection.reloadData()
    }

    func loadMore(page: Int) {
        presenter.getMovies(with: page)
    }

    func showDetailMovie(movie: Movie) {
        coordinator?.showMovieDetail(with: movie)
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
