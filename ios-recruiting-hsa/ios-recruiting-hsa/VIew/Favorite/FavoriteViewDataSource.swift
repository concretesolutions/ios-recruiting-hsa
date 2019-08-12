//
//  FavoriteViewDataSource.swift
//  ios-recruiting-hsa
//
//  Created on 8/12/19.
//

import UIKit

class FavoriteViewDataSource: NSObject {
    private var view: FavoriteViewController?
    
    func attach(view: FavoriteViewController) {
        self.view = view
    }
}

extension FavoriteViewDataSource: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return view?.movies.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let identifier = String(describing: FavoriteTableViewCell.self)
        var cell = tableView.dequeueReusableCell(withIdentifier: identifier) as? FavoriteTableViewCell
        
        if (cell == nil) {
            cell = FavoriteTableViewCell(style: .default, reuseIdentifier: identifier)
        }
        
        if let view = view {
            let movie = view.movies[indexPath.row]
            cell?.configure(imageUrl: movie.posterPath,
                            title: movie.title,
                            year: movie.year,
                            overview: movie.overview
            )
        }
        
        return cell ?? FavoriteTableViewCell()
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if (editingStyle == .delete) {
            view?.delete(row: indexPath.row)
//            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
}
