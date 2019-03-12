import Foundation
import UIKit

extension MovieDetailViewController {
    override func numberOfSections(in _: UITableView) -> Int {
        return MovieDetailViewControllerSections.allCases.count
    }

    override func tableView(_: UITableView, numberOfRowsInSection _: Int) -> Int {
        return 1
    }

    override func tableView(_: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        let section = indexPath.section
        guard let detailViewSection = MovieDetailViewControllerSections(rawValue: section) else { return 0 }

        switch detailViewSection {
        case .image:
            return MovieDetailImageCell.defaultHeight
        case .overview:
            return MovieDetailTextCell.defaultHeight
        default:
            return 70
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
            return getReusableCell(tableView: tableView, title: nil, detail: model?.title)
        case .average:
            return UITableViewCell() // get average cell
        case .overview:
            return getOverviewCell(tableView: tableView, text: model?.overview)
        case .year:
            return getReusableCell(tableView: tableView, title: nil, detail: model?.humanDate)
        case .image:
            return getImageCell(imgPath: model?.posterPath)
        }
    }

    private func getReusableCell(tableView: UITableView, title: String?, detail: String?) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: reusableCellIdentifier) else { return UITableViewCell() }
        cell.textLabel?.text = title
        cell.detailTextLabel?.text = detail
        return cell
    }

    private func getOverviewCell(tableView: UITableView, text: String?) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: MovieDetailTextCell.reusableIdentifier) as? MovieDetailTextCell else { return UITableViewCell() }
        cell.setupCell(text: text)
        return cell
    }

    private func getImageCell(imgPath: String?) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: MovieDetailImageCell.reusableIdentifier) as? MovieDetailImageCell else { return UITableViewCell() }
        cell.setupCell(imgPath: imgPath, configurations: Configurations()!)
        return cell
    }
}
