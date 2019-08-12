//
//  DetailViewController.swift
//  ios-recruiting-hsa
//
//  Created on 11-08-19.
//

import UIKit

class DetailViewController: BaseViewController {
    @IBOutlet
    weak var tableView: UITableView!
    private let presenter: DetailPresenter
    private let delegate: DetailViewDelegate
    private let datasource: DetailViewDataSource
    var movie: MovieDetailView! {
        didSet {
            tableView.reloadData()
        }
    }
    var movieId: Int = 0
    var favoriteDelegate: FavoriteDelegate? {
        didSet {
            presenter.isFavorite(movieId: movieId)
        }
    }
    
    init(presenter: DetailPresenter,
         delegate: DetailViewDelegate,
         datasource: DetailViewDataSource
    ) {
        self.presenter = presenter
        self.delegate = delegate
        self.datasource = datasource
        super.init(nibName: String(describing: DetailViewController.self), bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = Constants.Labels.detailTitle
        delegate.attach(view: self)
        datasource.attach(view: self)
        presenter.attach(view: self)
        presenter.movieDetail(id: movieId)
    }
    
    override func prepare() {
        super.prepare()
        prepareTableView()
    }
    
    private func prepareTableView() {
        let imageCellName = String(describing: ImageTableViewCell.self)
        tableView.register(UINib(nibName: imageCellName, bundle: nil), forCellReuseIdentifier: imageCellName)
        let labelCellName = String(describing: LabelTableViewCell.self)
        tableView.register(UINib(nibName: labelCellName, bundle: nil), forCellReuseIdentifier: labelCellName)
        let overviewCellName = String(describing: OverviewTableViewCell.self)
        tableView.register(UINib(nibName: overviewCellName, bundle: nil), forCellReuseIdentifier: overviewCellName)
        tableView.delegate = delegate
        tableView.dataSource = datasource
        tableView.separatorStyle = .none
        tableView.tableFooterView = UIView(frame: .zero)
    }
    
    func makeFavorite() {
        presenter.addFavorite(movie: movie)
    }
}

extension DetailViewController: DetailView {
    func show(detail movie: MovieDetailView) {
        self.movie = movie
    }
    
    func markFavorite() {
        favoriteDelegate?.markFavorite()
    }
}
