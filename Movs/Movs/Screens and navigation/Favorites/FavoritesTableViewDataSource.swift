//
//  FavoritesTableViewDataSource.swift
//  Movs
//
//  Created by Miguel Duran on 1/8/19.
//  Copyright © 2019 Miguel Duran. All rights reserved.
//

import UIKit

class FavoritesTableViewDataSource: NSObject {
    var dataOrganizer: DataOrganizer
    
    init(movies: [Movie]) {
        dataOrganizer = DataOrganizer(movies: movies)
    }
    
    func movie(at index: Int) -> Movie {
        return dataOrganizer.movie(at: index)
    }
}

extension FavoritesTableViewDataSource: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataOrganizer.rowCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let movie = dataOrganizer.movie(at: indexPath.row)
        let cell: FavoriteMovieCell = tableView.dequeueReusableCell(for: indexPath)
        cell.viewModel = FavoriteMovieCell.ViewModel(movie: movie)
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            dataOrganizer.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
    }
}

extension FavoritesTableViewDataSource {
    struct DataOrganizer {
        private var movies: [Movie]
        
        var rowCount: Int {
            return self.movies.count
        }
        
        init(movies: [Movie]) {
            self.movies = movies
        }
        
        func movie(at index: Int) -> Movie {
            return self.movies[index]
        }
        
        mutating func remove(at index: Int) {
            self.movies.remove(at: index)
        }
    }
}
