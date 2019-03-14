import ICSPullToRefresh
import UIKit

class MovieListViewController: UICollectionViewController {
    var presenter: MovieListPresenterProtocol?
    internal var movies: [MovieModel] = []
    internal var moviesIds: [Int] = []
    internal let refreshControl = UIRefreshControl()
    var configurations: ConfigurationsProtocol!
    var hudProvider: HUDProvider?
    var genres: [GenreModel] = []
    var page = 1

    // MARK: UIViewController lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.viewDidLoad()
        setupCollectionView()
        setupNavigationBar()
        setupPullToRefresh()
        setupInfiniteScroll()
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

    private func setupInfiniteScroll() {
        collectionView.addInfiniteScrollingWithHandler {
            self.presenter?.willLoadMovies(page: self.page + 1, append: true)
        }
    }

    @objc func willRefreshList() {
        presenter?.willLoadMovies(page: 1, append: false)
    }
}

extension MovieListViewController: MovieListViewProtocol {
    func setMovies(movies: [MovieModel], append: Bool) {
        if append {
            self.movies.append(contentsOf: movies)
            page += 1
        } else {
            self.movies.removeAll()
            self.movies.append(contentsOf: movies)
            page = 1
        }

        OperationQueue.main.addOperation {
            if append {
                self.collectionView.performBatchUpdates({
                    self.collectionView.reloadSections(IndexSet([0]))
                }, completion: nil)
            } else {
                self.collectionView.reloadData()
            }

            self.refreshControl.endRefreshing()
            self.collectionView.infiniteScrollingView?.stopAnimating()
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
            self.collectionView.infiniteScrollingView?.stopAnimating()
        }
    }
}
