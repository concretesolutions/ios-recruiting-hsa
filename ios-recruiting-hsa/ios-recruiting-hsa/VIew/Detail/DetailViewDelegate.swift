//
//  DetailViewDelegate.swift
//  ios-recruiting-hsa
//
//  Created on 11-08-19.
//

import UIKit

class DetailViewDelegate: NSObject {
    private var view: DetailViewController?
    
    func attach(view: DetailViewController) {
        self.view = view
    }
}

extension DetailViewDelegate: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == DetailConstants.Cells.Indexes.image {
            return UIScreen.main.bounds.height * 0.5
        } else {
            return UITableView.automaticDimension
        }
    }
}
