import UIKit

class MovieListViewController: UIViewController {
    var presenter: MovieListPresenterProtocol?
    internal var movies: [MovieModel] = []
    internal var moviesIds: [Int] = []

    convenience init(presenter: MovieListPresenterProtocol) {
        self.init(nibName: MovieListViewController.nameOfClass, bundle: nil)
        self.presenter = presenter
    }

    // MARK: UIViewController lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        // presenter.viewDidLoad()
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

        // reload data
    }

    func setSavedMoviesIds(ids: [Int], append: Bool) {
        if append {
            moviesIds.append(contentsOf: ids)
        } else {
            moviesIds.removeAll()
            moviesIds.append(contentsOf: ids)
        }
    }

    func showLoading() {}

    func hideLoading() {}
}
