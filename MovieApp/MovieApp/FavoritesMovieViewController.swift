//
//  FavoritesMovieViewController.swift
//  MovieApp
//
//  Created by Sebastian Diaz on 4/6/19.
//  Copyright © 2019 Accenture. All rights reserved.
//

import UIKit
import SDWebImage

protocol FavoritesMovieViewProtocol : class {
    func showMovies(movies: [MovieViewModel])
    func removeFavorite(movie : MovieViewModel)
    func filterData()
}

class FavoritesMovieViewController: UIViewController {

    @IBOutlet weak var tableView : UITableView!
    
    var presenter : MovieFavoritePresenter?
    var router : FavoritesRouterProtocol?
    var interactor : MovieFavoriteInteractor?
    var viewModels : [MovieViewModel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.tableFooterView = UIView(frame: .zero)
        self.tableView.dataSource = self
        self.tableView.delegate = self
        self.tableView.register(UINib(nibName: "FavoriteMovieTableViewCell", bundle: nil), forCellReuseIdentifier: "CELLFAVORITE")
        router = FavoritesRouter(presenting: self)
        presenter = MovieFavoritePresenter()
        presenter!.attachView(view: self)
        interactor = MovieFavoriteInteractor()
        presenter?.interactor = interactor
        interactor?.presenter = presenter
        presenter?.router = router
        navigationBarStyle()
        
        presenter?.fetchFavoriteMovies()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        presenter?.fetchFavoriteMovies()
    }
    
    func navigationBarStyle(){
        self.title = "Favorites Movies"
        self.navigationController?.navigationBar.barTintColor = #colorLiteral(red: 0.9686772227, green: 0.8077141047, blue: 0.3574544787, alpha: 1)
        self.navigationController?.navigationBar.isTranslucent = false
        self.navigationController?.navigationBar.tintColor = .black
        let barItem = UIBarButtonItem(image: UIImage(named: "FilterIcon"), style: .done, target: self, action: #selector(filterButtonAction))
        navigationItem.rightBarButtonItems=[barItem]
    }
    
    @objc func filterButtonAction(){
        presenter?.showFilterView()
    }
    
}

extension FavoritesMovieViewController : FavoritesMovieViewProtocol{
    func removeFavorite(movie: MovieViewModel) {
        presenter?.unFavoriteMovie(movie: movie)
    }
    
    func filterData() {
        
    }
    
    func showMovies(movies: [MovieViewModel]) {
        self.viewModels = movies
        self.tableView.reloadData()
    }

}


extension FavoritesMovieViewController : UITableViewDelegate{
    
    
}


extension FavoritesMovieViewController : UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CELLFAVORITE") as! FavoriteMovieTableViewCell
        let viewModel = viewModels[indexPath.row]
        cell.titleLabel.text = viewModel.title
        cell.yearLabel.text = viewModel.year
        cell.overviewLabel.text = viewModel.overview
        cell.posterImage.sd_setImage(with: URL(string: "https://image.tmdb.org/t/p/w500"+viewModel.imagePath), placeholderImage: nil)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt: IndexPath) -> [UITableViewRowAction]? {
        let unfavorite = UITableViewRowAction(style: .normal, title: "Unfavorite") { action, indexpath in
            let movie = self.viewModels[indexpath.row]
            self.removeFavorite(movie: movie)
        }
        unfavorite.backgroundColor = .red
        
        return [unfavorite]
    }

}
