import Foundation
import UIKit

extension SavedMoviesViewController {
    override func numberOfSections(in _: UITableView) -> Int {
        return 1
    }

    override func tableView(_: UITableView, numberOfRowsInSection _: Int) -> Int {
        return movies.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: SavedMovieCell.reusableIdentifier) as? SavedMovieCell else { return UITableViewCell() }
        guard indexPath.row < movies.count, !movies.isEmpty else { return UITableViewCell() }
        let movie = movies[indexPath.row]
        cell.setupCell(title: movie.title, date: movie.humanDate, average: movie.voteAverage, imgPath: movie.posterPath, configurations: configurations)
        return cell
    }

    override func tableView(_: UITableView, heightForRowAt _: IndexPath) -> CGFloat {
        return SavedMovieCell.defaultHeight
    }

    override func tableView(_: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard indexPath.row < movies.count, !movies.isEmpty else { return }
        let movie = movies[indexPath.row]
        presenter?.didTapInMovieCell(movie: movie, genres: [], isIpad: UIDevice.current.userInterfaceIdiom == .pad)
    }
}
