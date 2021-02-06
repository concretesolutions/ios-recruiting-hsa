//
//  MovieDetailViewController.swift
//  Movies
//
//  Created by Alfredo Luco on 05-02-21.
//

import UIKit

class MovieDetailViewController: ViewController {
    
    //MARK: - IBOutlets
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var summaryLabel: UILabel!
    @IBOutlet weak var genreLabel: UILabel!
    @IBOutlet weak var yearLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var thumb: UIImageView!
    @IBOutlet weak var mainStackView: UIStackView!
    
    //MARK: - Memory debug
    
    deinit {
        print("Movie detail vc dealloc")
    }
    
    //MARK: - Variables
    
    var presenter: MovieDetailPresenter = MovieDetailPresenter()
    var movie: Movie = Movie()

    //MARK: - App lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        self.activityIndicator.startAnimating()
        self.presenter.fetchMovie()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.isHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.tabBarController?.tabBar.isHidden = false
    }
    
    //MARK: - Functions
    
    func setupUI() {
        mainStackView.setCustomSpacing(24.0, after: thumb)
        mainStackView.setCustomSpacing(8.0, after: nameLabel)
        nameLabel.textColor = .black
        nameLabel.font = UIFont.systemFont(ofSize: 32.0)
        mainStackView.setCustomSpacing(8.0, after: yearLabel)
        yearLabel.textColor = .black
        yearLabel.font = UIFont.systemFont(ofSize: 16.0)
        mainStackView.setCustomSpacing(8.0, after: genreLabel)
        genreLabel.textColor = .black
        genreLabel.font = UIFont.systemFont(ofSize: 16.0)
        summaryLabel.textColor = .lightGray
        summaryLabel.font = UIFont.systemFont(ofSize: 16.0)
    }

}

//MARK: - Display Logic

extension MovieDetailViewController: PresenterToViewMovieDetailProtocol {
    func fetchMovieSuccessfull(_ movie: Movie) {
        self.movie = movie
        self.nameLabel.text = movie.title
        if let url = URL(string: Constants.mediaURL + "/original/\(movie.poster_path ?? "")") {
            thumb.load(url: url)
        }
        self.yearLabel.text = String(movie.release_date?.split(separator: "-").first ?? "")
        self.summaryLabel.text = movie.overview
        self.presenter.fetchCategories()
    }
    
    func fetchCategoriesSuccessfull(_ categories: [Category]) {
        let arr = categories.filter { (cat) -> Bool in
            return (self.movie.genre_ids?.contains(where: { $0 == cat.id })) ?? false
        }.compactMap({ $0.name })
        let str = arr.joined(separator: ",")
        DispatchQueue.main.async {
            self.activityIndicator.stopAnimating()
            self.activityIndicator.isHidden = true
            self.genreLabel.text = str
        }
    }
    
    func failure(_ error: Error) {
        let alert = UIAlertController(title: "ATENCION", message: error.localizedDescription, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}
