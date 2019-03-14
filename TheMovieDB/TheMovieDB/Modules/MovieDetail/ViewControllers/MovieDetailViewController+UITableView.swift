import Foundation
import UIKit

extension MovieDetailViewController {
    override func numberOfSections(in _: UITableView) -> Int {
        return MovieDetailViewControllerSections.allCases.count
    }

    override func tableView(_: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let detailViewSection = MovieDetailViewControllerSections(rawValue: section) else { return 0 }
        switch detailViewSection {
        case .genres:
            return genres.isEmpty ? 0 : 1
        default:
            return 1
        }
    }

    override func tableView(_: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        let section = indexPath.section
        guard let detailViewSection = MovieDetailViewControllerSections(rawValue: section) else { return 0 }

        switch detailViewSection {
        case .image:
            return MovieDetailImageCell.defaultHeight
        case .overview:
            return MovieDetailMultilineCell.defaultHeight
        default:
            return MovieDetailTextCell.defaultHeight
        }
    }

    override func tableView(_: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let section = indexPath.section
        guard let detailViewSection = MovieDetailViewControllerSections(rawValue: section) else { return 0 }

        switch detailViewSection {
        case .image:
            return MovieDetailImageCell.defaultHeight
        default:
            return UITableView.automaticDimension
        }
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let section = indexPath.section
        guard let detailViewSection = MovieDetailViewControllerSections(rawValue: section) else { return UITableViewCell() }

        switch detailViewSection {
        case .title:
            return getReusableCell(tableView: tableView, title: MovieDetailLocalizer.cellTitle.localizedString, detail: model?.title)
        case .average:
            let average = model?.voteAverage ?? 0
            return getReusableCell(tableView: tableView, title: MovieDetailLocalizer.cellAverage.localizedString, detail: String(format: "%.1f", average))
        case .overview:
            return getMultilineCell(tableView: tableView, title: MovieDetailLocalizer.cellOverview.localizedString, text: model?.overview)
        case .date:
            return getReusableCell(tableView: tableView, title: MovieDetailLocalizer.cellDate.localizedString, detail: model?.humanDate)
        case .image:
            return getImageCell(imgPath: model?.posterPath)
        case .genres:
            var genreString = ""
            for genre in genres {
                genreString += "\(genre)\n"
            }
            genreString = String(genreString.dropLast())
            return getMultilineCell(tableView: tableView, title: MovieDetailLocalizer.cellGenres.localizedString, text: genreString)
        }
    }

    private func getReusableCell(tableView: UITableView, title: String?, detail: String?) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: MovieDetailTextCell.reusableIdentifier) as? MovieDetailTextCell else { return UITableViewCell() }
        cell.setupCell(title: title, detail: detail)
        return cell
    }

    private func getMultilineCell(tableView: UITableView, title: String?, text: String?) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: MovieDetailMultilineCell.reusableIdentifier) as? MovieDetailMultilineCell else { return UITableViewCell() }
        cell.setupCell(title: title, text: text)
        return cell
    }

    private func getImageCell(imgPath: String?) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: MovieDetailImageCell.reusableIdentifier) as? MovieDetailImageCell else { return UITableViewCell() }
        cell.setupCell(imgPath: imgPath, configurations: configurations)
        return cell
    }
}
