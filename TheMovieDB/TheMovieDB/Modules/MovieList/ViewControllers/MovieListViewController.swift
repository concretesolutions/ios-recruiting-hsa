import UIKit

class MovieListViewController: UICollectionViewController {
    var presenter: MovieListPresenterProtocol?
    internal var movies: [MovieModel] = []
    internal var moviesIds: [Int] = []
    internal let refreshControl = UIRefreshControl()
    var configurations: ConfigurationsProtocol!
    var hudProvider: HUDProvider?
    var genres: [GenreModel] = []

    // MARK: UIViewController lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.viewDidLoad()
        setupCollectionView()
        setupNavigationBar()
        setupPullToRefresh()
    }

    private func setupCollectionView() {
        collectionView.register(MovieListCell.nib, forCellWithReuseIdentifier: MovieListCell.reusableIdentifier)
        if #available(iOS 11.0, *) {
            collectionView.contentInsetAdjustmentBehavior = .always
        }
    }

    private func setupNavigationBar() {
        navigationItem.title = MovieListLocalizer.movieListTitle.localizedString
    }

    private func setupPullToRefresh() {
        refreshControl.addTarget(self, action: #selector(willRefreshList), for: .valueChanged)
        collectionView.refreshControl = refreshControl
    }

    @objc func willRefreshList() {
        presenter?.willLoadMovies(page: 1, append: false)
    }
}

extension MovieListViewController: MovieListViewProtocol {
    func setMovies(movies: [MovieModel], append: Bool) {
        if append {
            self.movies.append(contentsOf: movies)
        } else {
            self.movies.removeAll()
            self.movies.append(contentsOf: movies)
        }

        OperationQueue.main.addOperation {
            self.collectionView.reloadData()
            self.refreshControl.endRefreshing()
        }
    }

    func setSavedMoviesIds(ids: [Int], append: Bool) {
        if append {
            moviesIds.append(contentsOf: ids)
        } else {
            moviesIds.removeAll()
            moviesIds.append(contentsOf: ids)
        }
        OperationQueue.main.addOperation {
            self.collectionView.reloadData()
        }
    }

    func setGenres(genres: [GenreModel]) {
        self.genres = genres
    }

    func showLoading() {
        hudProvider?.showLoading()
    }

    func hideLoading() {
        hudProvider?.hideLoading()
        OperationQueue.main.addOperation {
            self.refreshControl.endRefreshing()
        }
    }
}
