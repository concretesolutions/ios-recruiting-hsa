//
//  FavoriteMoviesViewController.swift
//  movs
//
//  Created by Andrés Alexis Rivas Solorzano on 10/2/19.
//  Copyright © 2019 Andrés Alexis Rivas Solorzano. All rights reserved.
//

import UIKit

protocol FavoritesMoviesDisplayLogic: class {
    func updateViewModel(viewModel: LocalMovieListViewModel)
    func displayFiltersView(filterList: [FilterModel])
}

class FavoriteMoviesViewController: BaseSearchViewController {
    
    @IBOutlet weak var tableView: UITableView!
    let router: FavoriteMoviesRouter
    private var interactor: FavoriteMoviesInteractor?
    private var viewModel: LocalMovieListViewModel?{
        didSet{
            DispatchQueue.main.async {
                self.updateUI()
            }
        }
    }
    
    init(router: FavoriteMoviesRouter){
        self.router = router
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        setupTableView()
        setupSearchBar()
        router.setupFilterButton()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        interactor?.getMovies()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        router.updateNavigationTitle()
    }

    private func setup(){
        let presenter = FavoriteMoviesPresenter(view: self)
        let loader = GenreListLoader(client: URLSessionHTTPClient())
        interactor = FavoriteMoviesInteractor(presenter: presenter, loader: loader)
    }
    
    private func updateUI(){
        tableView.reloadData()
    }
    
    @objc func showFilters(){
        interactor?.prepareFilters()
    }
    
    override func updateSearchResults(for searchController: UISearchController) {
        guard let searchQuery = searchController.searchBar.text else { return }
        interactor?.filterMovies(filterQuery: searchQuery)
    }
}

extension FavoriteMoviesViewController: FavoritesMoviesDisplayLogic{
    func displayFiltersView(filterList: [FilterModel]) {
        DispatchQueue.main.async {
            self.router.routeToFilters(filtersList: filterList, delegate: self)
        }
    }
    
    func updateViewModel(viewModel: LocalMovieListViewModel) {
        self.viewModel = viewModel
    }
}

extension FavoriteMoviesViewController: FiltersSelectionDelegate{
    func updateFilters(filterList: [FilterModel]) {
        interactor?.updateFilters(filterList: filterList)
    }
}

extension FavoriteMoviesViewController: UITableViewDataSource, UITableViewDelegate{
   
    func setupTableView(){
        tableView.tableFooterView = UIView()
        tableView.register(UINib.init(nibName: FavoriteMovieTableViewCell.reuseIdentifier, bundle: nil),
                           forCellReuseIdentifier: FavoriteMovieTableViewCell.reuseIdentifier)
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.movieList.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: FavoriteMovieTableViewCell.reuseIdentifier, for: indexPath)
        
        if let cell = cell as? FavoriteMovieTableViewCell, let movie = viewModel?.movieList[indexPath.row]{
            cell.updateInfo(item: movie)
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let movie = viewModel?.movieList[indexPath.row] else { return }
        router.routeToDetail(from: movie.id, withTitle: movie.title)
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete, let movieToDelete = viewModel?.movieList[indexPath.row]{
            interactor?.unFavMovie(movieId: movieToDelete.id)
        }
    }
    
}
