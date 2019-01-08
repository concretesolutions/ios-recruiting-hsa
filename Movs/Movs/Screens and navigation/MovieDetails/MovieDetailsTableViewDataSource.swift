//
//  MovieDetailsTableViewDataSource.swift
//  Movs
//
//  Created by Miguel Duran on 1/7/19.
//  Copyright © 2019 Miguel Duran. All rights reserved.
//

import UIKit

class MovieDetailsTableViewDataSource: NSObject {
    var dataOrganizer: DataOrganizer
    
    init(movie: Movie) {
        dataOrganizer = DataOrganizer(movie: movie)
    }
    
    func toggleFavorite(at index: Int) {
        dataOrganizer.toggleFavorite(at: index)
    }
    
    var isFavorite: Bool {
        return dataOrganizer.isFavorite
    }
}

extension MovieDetailsTableViewDataSource: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataOrganizer.rowCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let row = dataOrganizer.row(at: indexPath.row)
        let cell = tableView.dequeueReusableCell(with: row.cellType, for: indexPath)
        if let configurableCell = cell as? RowConfigurable {
            configurableCell.configure(with: row)
        }
        return cell
    }
}

extension MovieDetailsTableViewDataSource {
    struct DataOrganizer {
        private(set) var rows: [MovieDetailsViewController.Row]
        
        var rowCount: Int {
            return rows.count
        }
        
        init(movie: Movie) {
            let rows: [MovieDetailsViewController.Row] = [
                .poster(UIImage()),
                .titleFavorite("", false),
                .year(""),
                .genres(""),
                .overview("")]
            self.rows = rows.map { movie[$0] }
        }
        
        func row(at index: Int) -> MovieDetailsViewController.Row {
            return rows[index]
        }

        var isFavorite: Bool {
            for case let .titleFavorite(_, isFavorite) in rows {
                return isFavorite
            }
            return false
        }
        
        mutating func toggleFavorite(at index: Int) {
            let values: (String, Bool) = {
                for case let .titleFavorite(title, isFavorite) in rows {
                    return (title, isFavorite)
                }
                return ("", false)
            }()
            rows[index] = .titleFavorite(values.0, !values.1)
        }
    }
}

// MARK: RowConfigurable
protocol RowConfigurable {
    func configure(with row: MovieDetailsViewController.Row)
}

extension PosterCell: RowConfigurable {
    func configure(with row: MovieDetailsViewController.Row) {
        if case let .poster(image) = row {
            poster = image
        }
    }
}

extension DetailCell: RowConfigurable {
    func configure(with row: MovieDetailsViewController.Row) {
        switch row {
        case let .year(text), let .genres(text):
            detail = text
        default: break
        }
    }
}

extension TitleFavoriteCell: RowConfigurable {
    func configure(with row: MovieDetailsViewController.Row) {
        if case let .titleFavorite(title, isFavorite) = row {
            self.viewModel = TitleFavoriteCell.ViewModel(title: title, isFavorite: isFavorite)
        }
    }
}

extension OverviewCell: RowConfigurable {
    func configure(with row: MovieDetailsViewController.Row) {
        if case let .overview(text) = row {
            overview = text
        }
    }
}
