import UIKit

class SavedMoviesViewController: UITableViewController {
    var presenter: SavedMoviesPresenterProtocol?
    internal var hudProvider: HUDProvider?
    internal var movies: [MovieModel] = []
    internal var configurations: ConfigurationsProtocol!

    // MARK: UIViewController lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        setupNavigationBar()
        setupTabBarItem()
        presenter?.viewDidLoad()
    }

    private func setupTableView() {
        tableView.tableFooterView = UIView()
        tableView.register(SavedMovieCell.nib, forCellReuseIdentifier: SavedMovieCell.reusableIdentifier)
    }

    private func setupTabBarItem() {
        let image = UIImage(named: "favoriteIcon.full")
        let title = SavedMoviesLocalizer.savedMoviesTabBarItemTitle.localizedString
        tabBarItem = UITabBarItem(title: title, image: image, selectedImage: image)
    }

    private func setupNavigationBar() {
        navigationItem.title = SavedMoviesLocalizer.savedMoviesViewTitle.localizedString
    }
}

extension SavedMoviesViewController: SavedMoviesViewProtocol {
    func showLoading() {
        hudProvider?.showLoading()
    }

    func hideLoading() {
        hudProvider?.hideLoading()
    }

    func setMovies(_ movies: [MovieModel]) {
        self.movies = movies
        OperationQueue.main.addOperation {
            self.tableView.reloadData()
        }
    }

    func showMessage(_ message: String) {
        hudProvider?.showSuccessMessage(message)
    }
}
