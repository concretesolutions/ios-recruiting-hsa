//
//  GridViewController.swift
//  ios-recruiting-hsa
//
//  Created on 10-08-19.
//

import UIKit

class GridViewController: BaseViewController {
    @IBOutlet
    weak var collectionView: UICollectionView!
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
    
    override func prepare() {
        super.prepare()
        prepareCollectionView()
    }
    
    private func prepareCollectionView() {
        let cellName = String(describing: MovieCollectionViewCell.self)
        collectionView.register(UINib(nibName: cellName, bundle: nil), forCellWithReuseIdentifier: cellName)
        collectionView.delegate = delegate
        collectionView.dataSource = datasource
    }
    
    func pushViewController(viewController: UIViewController) {
        navigationController?.pushViewController(viewController, animated: true)
    }
    
    func endOfCollectionReached() {
        presenter?.popularMovies()
    }
}

extension GridViewController: GridView {
    func show(popular movies: [MovieView]) {
        self.movies.append(contentsOf: movies);
    }
}
