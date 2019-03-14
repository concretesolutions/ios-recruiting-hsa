import ICSPullToRefresh
import UIKit

class MovieListViewController: UICollectionViewController {
    var presenter: MovieListPresenterProtocol?
    internal var movies: [MovieModel] = []
    internal var moviesIds: Set<Int32> = []
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
        setupTabBarItem()
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

    private func setupTabBarItem() {
        let image = UIImage(named: "listIcon")
        tabBarItem = UITabBarItem(title: MovieListLocalizer.tabBarItemTitle.localizedString, image: image, selectedImage: image)
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

    func setSavedMoviesIds(ids: [Int32], append: Bool) {
        if !append {
            moviesIds.removeAll()
        }
        for movieId in ids {
            moviesIds.insert(movieId)
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

extension MovieListViewController: MovieListSavedAdsUpdate {
    func didUpdateSavedMovieState(movieId: Int32?, saved: Bool) {
        guard let movieId = movieId, let movie = movies.first(where: { $0.id == movieId }),
            let movieIndex = movies.index(of: movie) else { return }
        if saved {
            moviesIds.insert(movieId)
        } else {
            guard let movieIdIndex = moviesIds.index(of: movieId) else { return }
            moviesIds.remove(at: movieIdIndex)
        }

        OperationQueue.main.addOperation {
            self.collectionView.reloadItems(at: [IndexPath(item: movieIndex, section: 0)])
        }
    }
}
