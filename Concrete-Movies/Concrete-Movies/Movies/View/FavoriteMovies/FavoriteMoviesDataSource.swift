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
        if(viewController.searchActive){
            return viewController.filteredMoviesList.isEmpty ? 1 : viewController.filteredMoviesList.count
        }else{
            return moviesList.isEmpty ? 1 : moviesList.count
        }
        //return viewController.searchActive ? viewController.filteredMoviesList.count : moviesList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var cell = UITableViewCell()
        guard let viewController = viewController,
        let moviesList = viewController.moviesList else {return cell}
        
        if(viewController.searchActive){
            if(viewController.filteredMoviesList.isEmpty){
                cell = prepareEmptyListCell(tableView: tableView, indexPath: indexPath, searching: true)
            }else{
                cell = prepareFavoriteMovieCell(tableView: tableView, indexPath: indexPath)
            }
        }else if(moviesList.isEmpty){
            cell = prepareEmptyListCell(tableView: tableView, indexPath: indexPath, searching: false)
        }else{
            cell = prepareFavoriteMovieCell(tableView: tableView, indexPath: indexPath)
        }
        
        cell.selectionStyle = .none
        return cell
    }
    
    private func prepareFavoriteMovieCell(tableView: UITableView, indexPath: IndexPath)->UITableViewCell{
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
        
        favMovieCell.setup(movie: movies[indexPath.row])
        favMovieCell.delegate = viewController
        return favMovieCell
    }
    
    private func prepareEmptyListCell(tableView: UITableView, indexPath: IndexPath, searching: Bool)->UITableViewCell{
        guard let cell = tableView.dequeueReusableCell(withIdentifier: FavoriteMoviesConstants.emptyCellIdentifier, for: indexPath) as? EmptyMoviesListTableViewCell else {return UITableViewCell()}
        
        cell.setup(searchFailed: searching)
        
        return cell
    }
}
