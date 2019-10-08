//
//  MovieListViewController + UISearchResultsUpdating.swift
//  MovieScope
//
//  Created by Andrés Alexis Rivas Solorzano on 7/10/19.
//  Copyright © 2019 Andrés Alexis Rivas Solorzano. All rights reserved.
//

import Foundation
import UIKit

extension MovieListViewController: UISearchResultsUpdating, UISearchBarDelegate{
    
    func updateSearchResults(for searchController: UISearchController) {
        guard let queryText = searchController.searchBar.text else { return }
        viewModel.filterMovies(queryText)
    }
    
    func searchBarIsEmpty()->Bool{
        return searchController.searchBar.text?.isEmpty ?? true
    }
    
    func isFiltering() -> Bool {
        return searchController.isActive && !searchBarIsEmpty()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        guard let movieName = searchBar.text else { return }
        
        if !NetworkServiceManager.availableConnection{
            viewModel.searchOffLineData(movieName: movieName)
        }else{
            viewModel.searchOnlineData(query: movieName)
        }
    }
    
}
