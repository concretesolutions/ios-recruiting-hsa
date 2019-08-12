//
//  DetailViewDataSource.swift
//  ios-recruiting-hsa
//
//  Created on 11-08-19.
//

import UIKit

class DetailViewDataSource: NSObject {
    private var view: DetailViewController?
    
    func attach(view: DetailViewController) {
        self.view = view
    }
}

extension DetailViewDataSource: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return DetailConstants.Cells.rowCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let movie = view?.movie {
            switch indexPath.row {
            case DetailConstants.Cells.Indexes.image:
                return imageCell(tableView, cellForRowAt: indexPath, posterPath: movie.posterPath ?? "")
            case DetailConstants.Cells.Indexes.title:
                return labelCell(tableView, cellForRowAt: indexPath, text: movie.title)
            case DetailConstants.Cells.Indexes.year:
                return labelCell(tableView, cellForRowAt: indexPath, text: movie.releaseDate)
            case DetailConstants.Cells.Indexes.genere:
                return labelCell(tableView, cellForRowAt: indexPath, text: movie.genres.joined(separator: ", "))
            case DetailConstants.Cells.Indexes.overview:
                return overviewCell(tableView, cellForRowAt: indexPath, text: movie.overview ?? "")
            default:
                return UITableViewCell()
            }
        } else {
            return UITableViewCell()
        }
    }
    
    private func imageCell(_ tableView: UITableView, cellForRowAt indexPath: IndexPath, posterPath: String) -> UITableViewCell {
        let identifier = String(describing: ImageTableViewCell.self)
        var cell = tableView.dequeueReusableCell(withIdentifier: identifier) as? ImageTableViewCell
        
        if (cell == nil) {
            cell = ImageTableViewCell(style: .default, reuseIdentifier: identifier)
        }
        
        cell?.configure(imageUrl: posterPath)
        
        return cell ?? ImageTableViewCell()
    }
    
    private func labelCell(_ tableView: UITableView, cellForRowAt indexPath: IndexPath, text: String) -> UITableViewCell {
        let identifier = String(describing: LabelTableViewCell.self)
        var cell = tableView.dequeueReusableCell(withIdentifier: identifier) as? LabelTableViewCell
        
        if (cell == nil) {
            cell = LabelTableViewCell(style: .default, reuseIdentifier: identifier)
        }
        
        let showFavorite = indexPath.row == DetailConstants.Cells.Indexes.title
        cell?.configure(title: text,
                        showSeparator: indexPath.row != DetailConstants.Cells.Indexes.title,
                        showFavorite: showFavorite
        )
        
        if (showFavorite) {
            view?.favoriteDelegate = cell
        }
        
        return cell ?? LabelTableViewCell()
    }
    
    private func overviewCell(_ tableView: UITableView, cellForRowAt indexPath: IndexPath, text: String) -> UITableViewCell {
        let identifier = String(describing: OverviewTableViewCell.self)
        var cell = tableView.dequeueReusableCell(withIdentifier: identifier) as? OverviewTableViewCell
        
        if (cell == nil) {
            cell = OverviewTableViewCell(style: .default, reuseIdentifier: identifier)
        }
        
        cell?.configure(title: text)
        
        return cell ?? OverviewTableViewCell()
    }
}
