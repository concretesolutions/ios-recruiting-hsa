import UIKit

class MovieDetailViewController: UITableViewController {
    var presenter: MovieDetailPresenterProtocol?
    var model: MovieModel?
    private let sections = 1
    internal let reusableCellIdentifier = "TextCell"

    @IBOutlet var favoriteBarButtonItem: UIBarButtonItem!

    convenience init(presenter: MovieDetailPresenterProtocol) {
        self.init(nibName: MovieDetailViewController.nameOfClass, bundle: nil)
        self.presenter = presenter
    }

    // MARK: UIViewController lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        // presenter.viewDidLoad()
        setupTableView()
    }

    private func setupTableView() {
        tableView.tableFooterView = UIView()
        tableView.register(MovieDetailImageCell.nib, forCellReuseIdentifier: MovieDetailImageCell.reusableIdentifier)
        tableView.register(MovieDetailTextCell.nib, forCellReuseIdentifier: MovieDetailTextCell.reusableIdentifier)
    }
    @IBAction func favoriteBarButtonItemTapped(_: UIBarButtonItem) {}
}

extension MovieDetailViewController: MovieDetailViewProtocol {
    func showLoading() {}

    func hideLoading() {}
}

enum MovieDetailViewControllerSections: Int, CaseIterable {
    case image = 0, title, year, average, overview
}
