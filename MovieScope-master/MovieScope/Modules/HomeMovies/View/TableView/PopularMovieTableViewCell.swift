//
//  PopularMovieTableViewCell.swift
//  MovieScope
//
//  Created by Andrés Alexis Rivas Solorzano on 7/4/19.
//  Copyright © 2019 Andrés Alexis Rivas Solorzano. All rights reserved.
//

import UIKit

class PopularMovieTableViewCell: UITableViewCell, HomeConfigurableCell {

    @IBOutlet weak var tableView: AutoSizeTableView!
    
    var viewModel: HomeCellViewModel?
    var delegate: HomeMovieDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupTableView()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }

    
    override func prepareForReuse() {
        super.prepareForReuse()
        viewModel = nil
    }
    
    func setViewModel(viewModel: HomeCellViewModel) {
        self.viewModel = viewModel
        self.tableView.reloadData()
    }
    
}

extension PopularMovieTableViewCell: UITableViewDelegate, UITableViewDataSource{
    
    func setupTableView(){
        
        tableView.backgroundColor = .appBackgroundColor
        tableView.dataSource = self
        tableView.separatorStyle = .none
        tableView.delegate = self
        tableView.estimatedRowHeight = 234.5
        tableView.rowHeight = UITableView.automaticDimension
        let cellIdentifier = MovieResumeTableViewCell.reuseIdentifier
        tableView.register(UINib.init(nibName: cellIdentifier, bundle: nil), forCellReuseIdentifier: cellIdentifier)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       return self.viewModel?.movieList.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: MovieResumeTableViewCell.reuseIdentifier, for: indexPath)
        if let cell = cell as? MovieResumeTableViewCell, let movie = viewModel?.movieList[indexPath.row]{
            cell.updateInfo(movie: movie)
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        guard let movieId = viewModel?.movieList[indexPath.row].id else{
             print("Error al seleccionar pelicula")
            return
        }
        delegate?.showMovieDetail(movieId: movieId)
    }
    

}

