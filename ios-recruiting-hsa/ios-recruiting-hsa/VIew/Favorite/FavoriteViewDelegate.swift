//
//  FavoriteViewDelegate.swift
//  ios-recruiting-hsa
//
//  Created on 8/12/19.
//

import UIKit

class FavoriteViewDelegate: NSObject {
    private var view: FavoriteViewController?
    
    func attach(view: FavoriteViewController) {
        self.view = view
    }
}

extension FavoriteViewDelegate: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return FavoriteConstants.Cells.Favorite.height
    }
}
