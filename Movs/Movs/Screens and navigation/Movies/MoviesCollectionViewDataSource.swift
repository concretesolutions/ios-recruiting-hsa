//
//  MoviesCollectionViewDataSource.swift
//  TMDB Reloaded
//
//  Created by Miguel Duran on 1/6/19.
//  Copyright © 2019 Miguel Duran. All rights reserved.
//

import UIKit

class MoviesCollectionViewDataSource: NSObject {
    private var dataOrganizer: DataOrganizer
    
    init(movies: [Movie]) {
        self.dataOrganizer = DataOrganizer(movies: movies)
    }
    
    func addMovies(_ movies:[Movie]) {
        dataOrganizer.addMovies(movies)
    }
    
    func toggleFavorite(at index: Int) {
        dataOrganizer.toggleFavorite(at: index)
    }
    
    func movie(at index: Int) -> Movie {
        return dataOrganizer.movie(at: index)
    }
    
    func setFavorite(at index: Int, isFavorite: Bool) {
        dataOrganizer.setFavorite(at: index, isFavorite: isFavorite)
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
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
    
        let footer = collectionView.dequeueReusableSupplementaryView(withClass: FooterView.self, kind: UICollectionView.elementKindSectionFooter, at: indexPath)
        
        return footer
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
            return self.movies[index]
        }
        
        mutating func addMovies(_ movies: [Movie]) {
            self.movies.append(contentsOf: movies)
        }
        
        mutating func toggleFavorite(at index: Int) {
            self.movies[index].isFavorite = !self.movies[index].isFavorite
        }
        
        mutating func setFavorite(at index: Int, isFavorite: Bool) {
            self.movies[index].isFavorite = isFavorite
        }
    }
}

extension MovieCollectionViewCell.ViewModel {
    init(movie: Movie, posterImage: UIImage = UIImage()) {
        title = movie.title
        isFavorite = movie.isFavorite
        self.posterImage = posterImage
    }
}
