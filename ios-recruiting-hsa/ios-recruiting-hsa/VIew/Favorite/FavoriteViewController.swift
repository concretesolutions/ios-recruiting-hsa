//
//  FavoriteViewController.swift
//  ios-recruiting-hsa
//
//  Created on 8/12/19.
//

import UIKit

class FavoriteViewController: BaseViewController {
    @IBOutlet
    weak var tableView: UITableView!
    private let presenter: FavoritePresenter
    private let delegate: FavoriteViewDelegate
    private let datasource: FavoriteViewDataSource
    var movies = [FavoriteMovieView]() {
        didSet {
            tableView.reloadData()
        }
    }
    
    init(presenter: FavoritePresenter,
         delegate: FavoriteViewDelegate,
         datasource: FavoriteViewDataSource
    ) {
        self.presenter = presenter
        self.delegate = delegate
        self.datasource = datasource
        super.init(nibName: String(describing: FavoriteViewController.self), bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = Constants.Labels.favoritesTitle
        delegate.attach(view: self)
        datasource.attach(view: self)
        presenter.attach(view: self)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        presenter.favoriteMovies()
    }
    
    override func prepare() {
        super.prepare()
        prepareTableView()
    }
    
    private func prepareTableView() {
        let cellName = String(describing: FavoriteTableViewCell.self)
        tableView.register(UINib(nibName: cellName, bundle: nil), forCellReuseIdentifier: cellName)
        tableView.delegate = delegate
        tableView.dataSource = datasource
        tableView.tableFooterView = UIView(frame: .zero)
    }
    
    func delete(row index: Int) {
        presenter.deleteFavorite(movie: movies[index])
    }
}

extension FavoriteViewController: FavoriteView {
    func show(favorite movies: [FavoriteMovieView]) {
        self.movies.removeAll()
        self.movies.append(contentsOf: movies);
    }
    
    func deleted() {
        presenter.favoriteMovies()
    }
}
