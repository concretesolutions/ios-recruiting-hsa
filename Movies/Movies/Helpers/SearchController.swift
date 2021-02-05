//
//  SearchController.swift
//  CHV
//
//  Created by Alfredo Luco on 9/19/19.
//  Copyright © 2019 aluco. All rights reserved.
//

import UIKit

class SearchController: UISearchController {
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.searchBar.tintColor = .white
        self.searchBar.barTintColor  = .white
        DispatchQueue.main.async {
            self.searchBar.placeholder = NSLocalizedString("Buscar", comment: "name or category")
        }
    }
    
}
