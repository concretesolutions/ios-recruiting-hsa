//
//  FavoriteMoviesDataSource.swift
//  Concrete-Movies
//
//  Created by Audel Dugarte on 5/1/19.
//  Copyright © 2019 Audel Dugarte. All rights reserved.
//

import UIKit

class FavoriteMoviesDataSource: NSObject {
    weak var viewController: FavoriteMoviesViewController?
}

extension FavoriteMoviesDataSource: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let viewController = viewController,
            let moviesList = viewController.moviesList else {return 0}
        
        return viewController.searchActive ? viewController.filteredMoviesList.count : moviesList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let viewController = viewController,
            let movies = viewController.moviesList,
            let favMovieCell = tableView.dequeueReusableCell(
                withIdentifier: FavoriteMoviesConstants.favMovieCellIdentifier,
                for: indexPath) as? FavoriteMovieTableViewCell
        else {
            return UITableViewCell()
        }
        
        if(viewController.searchActive){
            favMovieCell.setup(movie: viewController.filteredMoviesList[indexPath.row])
        }else{
            favMovieCell.setup(movie: movies[indexPath.row])
        }
        favMovieCell.delegate = viewController
        favMovieCell.selectionStyle = .none
        return favMovieCell
    }
    
    
}
