import UIKit

class MovieDetailViewController: UITableViewController {
    var presenter: MovieDetailPresenterProtocol?
    var model: MovieModel?
    var hudProvider: HUDProvider?
    private var isSaved = false

    private let sections = 1
    internal let reusableCellIdentifier = "TextCell"

    @IBOutlet var favoriteBarButtonItem: UIBarButtonItem!

    private var closeBarButtonItem: UIBarButtonItem!

    convenience init(presenter: MovieDetailPresenterProtocol) {
        self.init(nibName: MovieDetailViewController.nameOfClass, bundle: nil)
        self.presenter = presenter
    }

    // MARK: UIViewController lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.viewDidLoad(movie: model)
        setupTableView()
        setupNavigationBar()
    }

    private func setupTableView() {
        tableView.tableFooterView = UIView()
        tableView.register(MovieDetailImageCell.nib, forCellReuseIdentifier: MovieDetailImageCell.reusableIdentifier)
        tableView.register(MovieDetailMultilineCell.nib, forCellReuseIdentifier: MovieDetailMultilineCell.reusableIdentifier)
        tableView.register(MovieDetailTextCell.nib, forCellReuseIdentifier: MovieDetailTextCell.reusableIdentifier)
    }

    private func setupNavigationBar() {
        navigationItem.title = model?.title
        if UIDevice.current.userInterfaceIdiom == .pad {
            closeBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(favoriteBarButtonItemTapped(_:)))
        }
    }

    @IBAction func favoriteBarButtonItemTapped(_: UIBarButtonItem) {
        guard let model = self.model else { return }
        presenter?.didTapSaveButton(movie: model, isDelete: isSaved)
    }

    @objc func closeBarButtonItemTapped(_: UIBarButtonItem) {
        presenter?.didTapCloseButton()
    }
}

extension MovieDetailViewController: MovieDetailViewProtocol {
    func showLoading() {
        hudProvider?.showLoading()
    }

    func hideLoading() {
        hudProvider?.hideLoading()
    }

    func updateSavedMovieStatus(saved: Bool) {
        OperationQueue.main.addOperation {
            self.isSaved = saved
            let imageName = self.isSaved ? "favoriteIcon.full" : "favoriteIcon.empty"
            self.favoriteBarButtonItem.image = UIImage(named: imageName)
        }
    }
}

enum MovieDetailViewControllerSections: Int, CaseIterable {
    case image = 0, title, year, average, overview
}
