//
//  MoviesCollectionViewDataSource.swift
//  TMDB Reloaded
//
//  Created by Miguel Duran on 1/6/19.
//  Copyright © 2019 Miguel Duran. All rights reserved.
//

import UIKit

class MoviesCollectionViewDataSource: NSObject {
    private let dataOrganizer: DataOrganizer
    
    init(movies: [Movie]) {
        self.dataOrganizer = DataOrganizer(movies: movies)
    }
}

extension MoviesCollectionViewDataSource: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataOrganizer.rowCount
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let movie = dataOrganizer.movie(at: indexPath.row)
        let cell: MovieCollectionViewCell = collectionView.dequeueReusableCell(at: indexPath)
        cell.viewModel = MovieCollectionViewCell.ViewModel(movie: movie)
        return cell
    }
}

extension MoviesCollectionViewDataSource {
    struct DataOrganizer {
        private var movies: [Movie]
        
        var rowCount: Int {
            return movies.count
        }
        
        init(movies: [Movie]) {
            self.movies = movies
        }
        
        func movie(at index: Int) -> Movie {
            return movies[index]
        }
    }
}

extension MovieCollectionViewCell.ViewModel {
    init(movie: Movie) {
        title = movie.title
    }
}
