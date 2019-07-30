//
//  MoviesDetailVC.swift
//  concreteMoviesApp
//
//  Created by Nebraska Melendez on 7/25/19.
//  Copyright © 2019 Nebraska Melendez. All rights reserved.
//

import UIKit
import SDWebImage

class MoviesDetailVC: UIViewController {
    
    
    //MARK: UIVars
    let tableView = UITableView(frame: .zero, style: .plain)
    
    //MARK: Vars
    
    let reuseIdentifier = "MovieDetailCell"
    var movie : MovieModel
    var genres : [GenreModel] = []
    var favoritesMovies:[MovieModel] = []
    var movies : [MovieModel] = []
    
    
    init (movie:MovieModel){
        self.movie = movie
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        self.setupView()
        self.setupViewCell()
        self.getGenres()
        self.getFavoritesMovies()
    }
    
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        tableView.frame = view.bounds
    }
    
 
    
    //MARK: Setups
    
    private func setupView() {
        
        //Confg TableView
        self.view.addSubview(tableView)
        self.tableView.separatorStyle = .none
        self.tableView.allowsSelection = false
        self.tableView.tableFooterView = UIView()
        self.tableView.estimatedRowHeight = 44
        self.tableView.rowHeight = UITableView.automaticDimension
        
        //Confg Navigation
        navigationItem.title = movie.title
        let backButtonItem = UIBarButtonItem()
        backButtonItem.title = ""
        backButtonItem.tintColor = .black
        self.navigationItem.backBarButtonItem = backButtonItem
        navigationController?.navigationBar.backgroundColor = UIColor.lightGray
        
        //Add Header view//
        
        let headerView = MovieDetailHeaderView.create()
        
        headerView.moviePoster.sd_setImage(with: movie.getImageFullSize())
        headerView.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height/2)
        tableView.tableHeaderView = headerView
        
        
    }
    
    private func setupViewCell() {
        
        let nibCell = UINib(nibName: reuseIdentifier, bundle: nil)
        tableView.register(nibCell, forCellReuseIdentifier: reuseIdentifier)
        
    }
    
    private func getGenres(){
        
        GlobalServices.shared.genreServices.getGenre() { (response) in
            
            switch response {
                
            case .success(data: let genre):
                
                self.genres = genre.genres
                
                DispatchQueue.main.async {
                    
                    self.tableView.reloadData()
                }
                
            case .error(error: let error):
                
                print(error.localizedDescription)
                
            }
            
        }
        
    }
    
    private func getFavoritesMovies(){
        
        self.favoritesMovies = LocalStorage.getFavoritesMovies()
        
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
}

//MARK: Implement TableView

extension MoviesDetailVC : UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier) as! MovieDetailCellVC
        
        cell.movieGenre.text = movie.getPrettyGenreList(of: genres)
        cell.movieTitle.text = movie.title
        cell.movieDate.text = movie.release_date
        cell.movieDetail.text = movie.overview
        
        let isFavorite = self.favoritesMovies.contains { (m) -> Bool in
            return m.id == movie.id
            
        }
        
        cell.delegate = self
        cell.favoriteButton.tintColor = isFavorite ? .red : .black
        return cell
        
    }
    
    
}



//MARK: Implement Movie Cell delegate
extension MoviesDetailVC: MovieDetailCellDelegate{
    
    func favoriteButtonTapped(in cell: MovieDetailCellVC) {
        
        // if movie is favorite
        if self.favoritesMovies.contains(where: { (m) -> Bool in
            return m.id == movie.id
        }){
            // delete of favorite
            LocalStorage.favoriteMovie(delete: movie)
            self.favoritesMovies = LocalStorage.getFavoritesMovies()
            
        }else{
            // add to favorite
            self.favoritesMovies.insert(movie, at: 0)
            LocalStorage.favoriteMovie(save: movie)
        }
        
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
}



