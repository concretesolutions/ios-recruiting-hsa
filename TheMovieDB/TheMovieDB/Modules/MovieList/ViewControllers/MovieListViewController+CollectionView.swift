import Foundation
import UIKit

extension MovieListViewController {
    override func numberOfSections(in _: UICollectionView) -> Int {
        return 1
    }

    override func collectionView(_: UICollectionView, numberOfItemsInSection _: Int) -> Int {
        return movies.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard indexPath.row < movies.count, !movies.isEmpty else {
            return UICollectionViewCell()
        }

        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MovieListCell.reusableIdentifier, for: indexPath) as? MovieListCell else {
            return UICollectionViewCell()
        }

        let movie = movies[indexPath.row]
        let isSaved = moviesIds.contains(movie.id)
        cell.setupCell(title: movie.title, isSaved: isSaved, imgPath: movie.posterPath, configurations: configurations)
        return cell
    }

    override func collectionView(_: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard indexPath.row < movies.count, !movies.isEmpty else { return }
        let movie = movies[indexPath.row]
        var movieGenres = [String]()
        for genreId in movie.genreIDS {
            if let genre = genres.first(where: { $0.id == genreId }) {
                movieGenres.append(genre.name)
            }
        }
        presenter?.didTapInMovieCell(movie: movie, genres: movieGenres, isIpad: UIDevice.current.userInterfaceIdiom == .pad)
    }
}
