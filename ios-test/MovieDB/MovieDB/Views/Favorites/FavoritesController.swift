//
//  FavoritesController.swift
//  MovieDB
//
//  Created by Eddwin Paz on 9/6/19.
//  Copyright © 2019 acme dot inc. All rights reserved.
//

import UIKit

class FavoritesController: UITableViewController {

    var shareView = FavoriteView()
    var dataSource = [MovieViewModel]()
    var viewModel = MovieViewModel(model: nil)

    override func viewWillAppear(_ animated: Bool) {
        shareView.dataSource = viewModel.getFavorites()
        shareView.tableView.reloadData()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Favorites"
        navigationItem.backBarButtonItem = UIBarButtonItem(title: nil, style: .plain, target: nil, action: nil)
    }

    override func loadView() {
        shareView.dataSource = dataSource
        shareView.controller = self
        view = shareView
    }
}
