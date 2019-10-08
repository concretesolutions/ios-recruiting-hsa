//
//  MovieListViewController.swift
//  movs
//
//  Created by Andrés Alexis Rivas Solorzano on 10/2/19.
//  Copyright © 2019 Andrés Alexis Rivas Solorzano. All rights reserved.
//

import UIKit

protocol MovieListDisplayLogic: class {
    func updateViewModel(viewModel: MovieListViewModel)
    func displaySearchResults(query: String)
}

class MovieListViewController: BaseSearchViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    let router: Wireframe
    private(set) var interactor: MovieListBusinessLogic?
    private(set) var viewModel: MovieListViewModel?{
        didSet{
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }
    }
    
    init(router: Wireframe, searchQuery: String? = nil){
        self.router = router
        super.init(nibName: nil, bundle: nil)
        setup(searchQuery: searchQuery)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
        setupSearchBar()
        interactor?.fetchMoreMovies()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        router.updateNavigationTitle()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        collectionView.reloadData()
    }
    
    private func setup(searchQuery: String?){
        let movieListLoader = RemoteMovieListLoader(client: URLSessionHTTPClient())
        let presenter = MovieListPresenter(view: self)
        interactor = MovieListInteractor(loader: movieListLoader, presenter: presenter, searchQuery: searchQuery)
    }
    
    private func setupCollectionView(){
        collectionView.register(UINib.init(nibName: MovieListCollectionViewCell.reuseIdentifier, bundle: nil),
                                forCellWithReuseIdentifier: MovieListCollectionViewCell.reuseIdentifier)
        collectionView.dataSource = self
        collectionView.delegate = self
    }
    
    override func updateSearchResults(for searchController: UISearchController) {
        if let query = searchController.searchBar.text {
            interactor?.filterMovies(filterQuery: query)
        }
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchQuery = searchBar.text else { return }
        interactor?.searchMovie(searchQuery: searchQuery)
    }
    
}

extension MovieListViewController: MovieListDisplayLogic {
    func updateViewModel(viewModel: MovieListViewModel) {
        self.viewModel = viewModel
    }
    
    func displaySearchResults(query: String) {
        DispatchQueue.main.async {
            self.router.routeToSearch(withQuery: query)
        }
    }
}


