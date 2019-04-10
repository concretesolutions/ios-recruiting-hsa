//
//  MovieDetailViewController.swift
//  MovieApp
//
//  Created by Sebastian Diaz on 4/5/19.
//  Copyright © 2019 Accenture. All rights reserved.
//

import UIKit
import SDWebImage

protocol MovieDetailViewProtocol : class{
    func showMovieDetail(movie : Movie)
}

class MovieDetailViewController: UIViewController {
    
    var viewModel : MovieViewModel?
    var presenter : MovieDetailPresenterProtocol?
    var interactor : MovieDetailInteractorProtocol?
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var imageTableView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Movie"
        interactor = MovieDetailInteractor()
        presenter = MovieDetailPresenter(interactor: interactor!)
        
        configTableView()
        tableView.reloadData()
    }
    
    func configTableView(){
        
        imageTableView.sd_setImage(with: URL(string: "https://image.tmdb.org/t/p/w500"+viewModel!.imagePath), placeholderImage: nil)

        tableView.tableFooterView = UIView(frame: .zero)
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.register(UINib(nibName: "DetailTableViewCell", bundle: nil), forCellReuseIdentifier:"CELLPROPERTYMOVIE" )
    }

}


extension MovieDetailViewController : UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0 {
            presenter?.addToFavoriteAction(movie: viewModel!)
            viewModel?.favorite = true
            self.tableView.reloadRows(at: [IndexPath(row: 0, section: 0)], with: .none)
        }
    }
    
}

extension MovieDetailViewController : UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CELLPROPERTYMOVIE") as! DetailTableViewCell
        cell.selectionStyle = .none
        switch indexPath.row {
        case 0:
            cell.titleLabel.text = viewModel?.title
            cell.favoriteImage.image = viewModel!.favorite ? UIImage(named: "favorite_full_icon") : UIImage(named: "favorite_gray_icon")
            cell.showIconFavorite()
        case 1:
            cell.titleLabel.text = viewModel?.year
            cell.hideIconFavorite()
        case 2:
            let genres = viewModel?.genres.map{$0.name}
            let stringRepresentation = genres?.joined(separator: ",")
            cell.titleLabel.text = stringRepresentation
            cell.hideIconFavorite()
        case 3:
            tableView.separatorStyle = .none
            cell.titleLabel.text = viewModel?.overview
            cell.hideIconFavorite()
        default:
            break;
        }
        
        return cell
        
    }
    
}



