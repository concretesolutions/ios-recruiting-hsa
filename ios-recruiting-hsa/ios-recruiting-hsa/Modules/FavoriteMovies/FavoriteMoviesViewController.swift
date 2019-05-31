//
//  FavoriteMoviesViewController.swift
//  ios-recruiting-hsa
//
//  Created by Hans Fehrmann on 5/28/19.
//  Copyright © 2019 Hans Fehrmann. All rights reserved.
//

import Foundation
import UIKit

class FavoriteMoviesViewController: UIViewController {

    @IBOutlet private weak var searchBar: CustomSearchBar!
    @IBOutlet private weak var tableView: UITableView!
    private weak var navigationBar: UINavigationBar?

    private var cellIdentifier = "CellIdentifier"
    private var viewModel: FavoriteMoviesViewModel

    init(viewModel: FavoriteMoviesViewModel) {
        self.viewModel = viewModel
        super.init(nibName: "FavoriteMovies", bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("This view should not be instantiaded by storyboard")
    }

    override func viewDidLoad() {
        tabBarItem.title = viewModel.title
        tabBarItem.image = .favoriteEmpty

        tableView.register(FavoriteMovieTableCell.self, forCellReuseIdentifier: cellIdentifier)
        tableView.rowHeight = 100
        tableView.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        tableView.separatorColor = .white
        tableView.tableHeaderView = UIView()
        tableView.tableFooterView = UIView()
        tableView.backgroundColor = .darkCell
        tableView.dataSource = self
        tableView.delegate = self

        searchBar.backgroundColor = .app
        searchBar.searchBackgroundColor = .darkApp

        view.backgroundColor = .darkCell

        navigationBar?.setBackgroundImage(UIImage(), for: .default)
        navigationBar?.shadowImage = UIImage()
        navigationBar?.topItem?.title = "Favorites"
    }

    override func viewWillAppear(_ animated: Bool) {
        tabBarController?.title = viewModel.title
    }
}

extension FavoriteMoviesViewController: UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let dequedCell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier)
        guard let cell = dequedCell as? FavoriteMovieTableCell else {
            return UITableViewCell()
        }
        return cell
    }
}

extension FavoriteMoviesViewController: UITableViewDelegate {

    func tableView(
        _ tableView: UITableView,
        editActionsForRowAt indexPath: IndexPath
    ) -> [UITableViewRowAction]? {
        let title = "Unfavorite"
        let unfavoriteAction = UITableViewRowAction(
            style: .default,
            title: title
        ) { _, _ in

        }
        return [unfavoriteAction]
    }

    func tableView(_ tableView: UITableView, shouldHighlightRowAt indexPath: IndexPath) -> Bool {
        return false
    }
}
