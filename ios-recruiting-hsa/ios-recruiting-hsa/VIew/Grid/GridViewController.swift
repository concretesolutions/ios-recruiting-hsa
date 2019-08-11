//
//  GridViewController.swift
//  ios-recruiting-hsa
//
//  Created on 10-08-19.
//

import UIKit

class GridViewController: UIViewController {
    @IBOutlet
    weak var collectionView: UICollectionView!
    private var activityIndicatorView = UIActivityIndicatorView(style: .whiteLarge)
    private let presenter: GridPresenter?
    private let delegate: GridViewDelegate?
    private let datasource: GridViewDataSource?
    var movies = [MovieView]() {
        didSet {
            collectionView.reloadData()
        }
    }
    private(set) var itemsPerRow: CGFloat = 2
    private(set) var sectionInsets = UIEdgeInsets(top: 50.0, left: 20.0, bottom: 50.0, right: 20.0)
    
    init(presenter: GridPresenter,
         delegate: GridViewDelegate,
         datasource: GridViewDataSource
        ) {
        self.presenter = presenter
        self.delegate = delegate
        self.datasource = datasource
        super.init(nibName: String(describing: GridViewController.self), bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = Constants.Labels.gridTitle
        delegate?.attach(view: self)
        datasource?.attach(view: self)
        presenter?.attach(view: self)
        presenter?.popularMovies()
    }
    
    private func prepareIndicatorView() {
        activityIndicatorView = UIActivityIndicatorView(style: .whiteLarge)
        activityIndicatorView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(activityIndicatorView)
        activityIndicatorView.backgroundColor = Constants.Colors.dark
        activityIndicatorView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        activityIndicatorView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        activityIndicatorView.layer.cornerRadius = activityIndicatorView.bounds.width / 2
    }
    
    private func prepareCollectionView() {
        let cellName = String(describing: MovieCollectionViewCell.self)
        collectionView.register(UINib(nibName: cellName, bundle: nil), forCellWithReuseIdentifier: cellName)
        collectionView.delegate = delegate
        collectionView.dataSource = datasource
    }
    
    func endOfCollectionReached() {
        presenter?.popularMovies()
    }
}

extension GridViewController: GridView {
    func prepare() {
        prepareIndicatorView()
        prepareCollectionView()
    }
    
    func showLoading() {
        view.isUserInteractionEnabled = false
        activityIndicatorView.startAnimating()
    }
    
    func hideLoading() {
        view.isUserInteractionEnabled = true
        activityIndicatorView.stopAnimating()
    }
    
    func show(popular movies: [MovieView]) {
        self.movies.append(contentsOf: movies);
    }
    
    func show(error: ErrorView) {
        let alertView = UIAlertController(title: "Error", message: error.statusMessage, preferredStyle: .alert)
        alertView.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        present(alertView, animated: true)
    }
}
