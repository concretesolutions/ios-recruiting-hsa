import UIKit

class MovieListViewController: UICollectionViewController {
    var presenter: MovieListPresenterProtocol?
    internal var movies: [MovieModel] = []
    internal var moviesIds: [Int] = []
    var configurations: ConfigurationsProtocol!
    var hudProvider: HUDProvider?
    var genres: [GenreModel] = []

    // MARK: UIViewController lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.viewDidLoad()
        setupCollectionView()
        setupNavigationBar()
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
    }
}
