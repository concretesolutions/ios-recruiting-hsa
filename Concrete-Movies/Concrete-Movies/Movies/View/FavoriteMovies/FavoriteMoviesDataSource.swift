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
        return viewController?.moviesList?.count ?? 0
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
        
        favMovieCell.setup(movie: movies[indexPath.row])
        
        return favMovieCell
    }
    
    
}
