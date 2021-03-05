//
//  ObjectDataSource.swift
//  Movies
//
//  Created by Daniel Nunez on 04-03-21.
//

import UIKit

class CollectionDelegateData: NSObject, UICollectionViewDelegate, UICollectionViewDataSource {

    weak var delegate: MovieListView?
    var movies: [Movie]
    var currentPage: Int = 1
    var selected: Int? = nil

    init(withDelegate delegate: MovieListView, _ movies: [Movie]) {
        self.delegate = delegate
        self.movies = movies

    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {

        self.delegate?.validMessage()
        return movies.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: MovieCollectionViewCell.identifier,
            for: indexPath
        ) as? MovieCollectionViewCell else {
            assertionFailure(
                "Cannot dequeue reusable cell \(MovieCollectionViewCell.self) with reuseIdentifier: \(MovieCollectionViewCell.identifier)"
            )
            return UICollectionViewCell()
        }

        cell.fill(with: movies[indexPath.row])

        return cell
    }

    func collectionView(_ collectionView: UICollectionView,
                        willDisplay cell: UICollectionViewCell,
                        forItemAt indexPath: IndexPath) {

        let row = indexPath.row
        if row == movies.endIndex - 1 {
            currentPage += 1
            self.delegate?.loadMore(page: currentPage)
        }
    }


    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.selected = indexPath.row
        self.delegate?.showDetailMovie(movie: movies[indexPath.row])
    }

}
