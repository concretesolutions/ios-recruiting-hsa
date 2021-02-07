//
//  StarredsViewController.swift
//  Movies
//
//  Created by Alfredo Luco on 07-02-21.
//

import UIKit

class StarredsViewController: ViewController {
    
    //MARK: - IBOutlets
    
    @IBOutlet weak var tableView: UITableView!
    
    //MARK: - Memory debug
    
    deinit {
        print("starreds vc dealloc")
    }
    
    //MARK: - Variables
    
    var presenter: StarredsPresenter = StarredsPresenter()
    var movies: [Movie] = []
    
    //MARK: - App lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        self.presenter.fetchStarredsMovies()
        // Do any additional setup after loading the view.
    }
    
    @objc func goToFilter() {
        let vc = FiltersRouter.createModule()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    //MARK: - Functions
    
    func setupUI() {
        self.tableView.register(UINib(nibName: String(describing: StarredMovieTableViewCell.self), bundle: Bundle(for: StarredMovieTableViewCell.self)), forCellReuseIdentifier: "starredIdentifier")
        self.tableView.estimatedRowHeight = 150.0
        self.tableView.rowHeight = UITableView.automaticDimension
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.navigationItem.setRightBarButton(UIBarButtonItem(image: UIImage(named: "ic_filter"), style: .plain, target: self, action: #selector(goToFilter)), animated: true)
    }

}

//MARK: - UITableView Delegate & Data Source

extension StarredsViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "starredIdentifier", for: indexPath) as? StarredMovieTableViewCell else {
            return UITableViewCell()
        }
        cell.movie = self.movies[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let action = UITableViewRowAction(style: .destructive, title: "Eliminar") { [weak self] (action, indexPath) in
            guard let movie = self?.movies[indexPath.row] else { return }
            self?.presenter.unstarMovie(movie.id)
        }
        return [action]
    }
}


//MARK: - Display Logic

extension StarredsViewController: PresenterToViewStarredsProtocol {
    func fetchStarredsMoviesSuccessfull(_ movies: [Movie]) {
        self.movies = movies
        self.tableView.reloadData()
    }
    
    func unstarMovieSuccessfull() {
        self.presenter.fetchStarredsMovies()
    }
    
    func failure(_ error: Error) {
        let alert = UIAlertController(title: "ATENCION", message: error.localizedDescription, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}
