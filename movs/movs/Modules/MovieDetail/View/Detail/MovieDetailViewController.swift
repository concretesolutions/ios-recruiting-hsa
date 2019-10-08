//
//  MovieDetailViewController.swift
//  movs
//
//  Created by Andrés Alexis Rivas Solorzano on 10/6/19.
//  Copyright © 2019 Andrés Alexis Rivas Solorzano. All rights reserved.
//

import UIKit
import Nuke

protocol MovieDetailDisplayLogic: class {
    func displayMovie(_ movieDetail: MovieDetailViewModel)
}

class MovieDetailViewController: UIViewController, MovieDetailDisplayLogic {

    @IBOutlet weak var movieImage: UIImageView!
    @IBOutlet weak var tableView: UITableView!
    
    private let router: MovieDetailRouter
    private var interactor: MovieDetailBusinessLogic?
    private var viewModel: MovieDetailViewModel?{
        didSet{
            DispatchQueue.main.async {
                self.updateUI()
            }
        }
    }
    let movieTitle: String
    
    init(router: MovieDetailRouter, movieId: Int, movieTitle: String){
        self.router = router
        self.movieTitle = movieTitle
        super.init(nibName: nil, bundle: nil)
        setup(with: movieId)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        interactor?.fetchMovieData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        router.updateNavigationTitle()
    }
    
    private func updateUI(){
        if let imageURL = viewModel?.movieImageURL{
            Nuke.loadImage(with: imageURL, into: movieImage)
        }
        tableView.reloadData()
    }
    
    private func setup(with movieId: Int){
        let loader = RemoteMovieDetailLoader(client: URLSessionHTTPClient())
        let presenter = MovieDetailPresenter(view: self)
        interactor = MovieDetailInteractor(movieId: movieId, loader: loader, presenter: presenter)
    }
    
    private func setupTableView(){
        tableView.register(UINib.init(nibName: AutoSizeTitleTableCell.reuseIdentifier, bundle: nil),
                           forCellReuseIdentifier: AutoSizeTitleTableCell.reuseIdentifier)
        tableView.tableFooterView = UIView()
        tableView.dataSource = self
    }
    
    func displayMovie(_ movieDetail: MovieDetailViewModel) {
        self.viewModel = movieDetail
    }

}

extension MovieDetailViewController: UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.featureList.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: AutoSizeTitleTableCell.reuseIdentifier, for: indexPath)
        
        if let cell = cell as? AutoSizeTitleTableCell, let feature = viewModel?.featureList[indexPath.row]{
            cell.titleLabel.text = feature
        }
        
        return cell
    }
    
    
}

